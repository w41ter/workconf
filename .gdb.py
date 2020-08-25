# coding: utf-8

import sys
import gdb.printing


if sys.version_info[0] >= 3:
    # GDB only permits converting a gdb.Value instance to its numerical address when using the
    # long() constructor in Python 2 and not when using the int() constructor. We define the
    # 'long' class as an alias for the 'int' class in Python 3 for compatibility.
    long = int  # pylint: disable=redefined-builtin,invalid-name


def get_unique_ptr(obj):
    """Read the value of a libstdc++ std::unique_ptr."""
    if "_M_t" in obj["_M_t"]:
        obj = obj["_M_t"]
    return obj["_M_t"]['_M_head_impl']


def absl_get_nodes(val):
    """
    Return a generator of all the nodes in a absl::container_internal::raw_hash_set
    and derived classes.
    """
    size = val["size_"]

    if size == 0:
        return

    table = val
    capacity = int(table["capacity_"])
    ctrl = table["ctrl_"]

    # Using the array of ctrl bytes, search for in-use slots and return them
    # https://github.com/abseil/abseil-cpp/blob/7ffbe09f3d85504bd018783bbe1e2c12992fe47c/absl/container/internal/raw_hash_set.h#L787-L788
    for x in range(capacity):
        ctrl_t = int(ctrl[x])
        if ctrl_t >= 0:
            yield table["slots_"][x]


class AbslHashSetPrinterBase(object):
    """Pretty-printer base class for absl::[node/flat]_hash_set<>."""

    def __init__(self, val, to_str):
        """Initialize absl::[node/flat]_hash_set."""
        self.val = val
        self.to_str = to_str

    @staticmethod
    def display_hint():
        """Display hint."""
        return 'array'

    def to_string(self):
        """Return absl::[node/flat]_hash_set for printing."""
        return "absl::%s_hash_set<%s> with %s elems " % (
            self.to_str, self.val.type.template_argument(0), self.val["size_"])


class AbslNodeHashSetPrinter(AbslHashSetPrinterBase):
    """Pretty-printer for absl::node_hash_set<>."""

    def __init__(self, val):
        """Initialize absl::node_hash_set."""
        AbslHashSetPrinterBase.__init__(self, val, "node")

    def children(self):
        """Children."""
        count = 0
        for val in absl_get_nodes(self.val):
            yield (str(count), val.dereference())
            count += 1


class AbslFlatHashSetPrinter(AbslHashSetPrinterBase):
    """Pretty-printer for absl::flat_hash_set<>."""

    def __init__(self, val):
        """Initialize absl::flat_hash_set."""
        AbslHashSetPrinterBase.__init__(self, val, "flat")

    def children(self):
        """Children."""
        count = 0
        for val in absl_get_nodes(self.val):
            yield (str(count), val.reference_value())
            count += 1


class AbslHashMapPrinterBase(object):
    """Pretty-printer base class for absl::[node/flat]_hash_map<>."""

    def __init__(self, val, to_str):
        """Initialize absl::[node/flat]_hash_map."""
        self.val = val
        self.to_str = to_str

    @staticmethod
    def display_hint():
        """Display hint."""
        return 'map'

    def to_string(self):
        """Return absl::[node/flat]_hash_map for printing."""
        return "absl::%s_hash_map<%s, %s> with %s elems " % (
            self.to_str, self.val.type.template_argument(0), self.val.type.template_argument(1),
            self.val["size_"])


class AbslNodeHashMapPrinter(AbslHashMapPrinterBase):
    """Pretty-printer for absl::node_hash_map<>."""

    def __init__(self, val):
        """Initialize absl::node_hash_map."""
        AbslHashMapPrinterBase.__init__(self, val, "node")

    def children(self):
        """Children."""
        for kvp in absl_get_nodes(self.val):
            yield ('key', kvp['first'])
            yield ('value', kvp['second'])


class AbslFlatHashMapPrinter(AbslHashMapPrinterBase):
    """Pretty-printer for absl::flat_hash_map<>."""

    def __init__(self, val):
        """Initialize absl::flat_hash_map."""
        AbslHashMapPrinterBase.__init__(self, val, "flat")

    def children(self):
        """Children."""
        for kvp in absl_get_nodes(self.val):
            yield ('key', kvp['key'])
            yield ('value', kvp['value'])


def find_match_brackets(search, opening='<', closing='>'):
    """Return the index of the closing bracket that matches the first opening bracket.
    Return -1 if no last matching bracket is found, i.e. not a template.
    Example:
        'Foo<T>::iterator<U>''
        returns 5
    """
    index = search.find(opening)
    if index == -1:
        return -1

    start = index + 1
    count = 1
    str_len = len(search)
    for index in range(start, str_len):
        char = search[index]

        if char == opening:
            count += 1
        elif char == closing:
            count -= 1

        if count == 0:
            return index

    return -1


class SubPrettyPrinter(gdb.printing.SubPrettyPrinter):
    """Sub pretty printer managed by the pretty-printer collection."""

    def __init__(self, name, prefix, is_template, printer):
        """Initialize SubPrettyPrinter."""
        super(SubPrettyPrinter, self).__init__(name)
        self.prefix = prefix
        self.printer = printer
        self.is_template = is_template


class PrettyPrinterCollection(gdb.printing.PrettyPrinter):
    """printer collection that ignores subtypes.
    It will match 'HashTable<T> but not 'HashTable<T>::iterator' when asked for 'HashTable'.
    """

    def __init__(self):
        """Initialize PrettyPrinterCollection."""
        super(PrettyPrinterCollection, self).__init__("bytekv", [])

    def add(self, name, prefix, is_template, printer):
        """Add a subprinter."""
        self.subprinters.append(SubPrettyPrinter(name, prefix, is_template, printer))

    def __call__(self, val):
        """Return matched printer type."""

        # Get the type name.
        lookup_tag = gdb.types.get_basic_type(val.type).tag
        if not lookup_tag:
            lookup_tag = val.type.name
        if not lookup_tag:
            return None

        index = find_match_brackets(lookup_tag)

        # Ignore subtypes of classes
        # We do not want HashTable<T>::iterator as an example, just HashTable<T>
        if index == -1 or index + 1 == len(lookup_tag):
            for printer in self.subprinters:
                if not printer.enabled:
                    continue
                if ((not printer.is_template or lookup_tag.find(printer.prefix) != 0)
                        and (printer.is_template or lookup_tag != printer.prefix)):
                    continue
                return printer.printer(val)

        return None


def build_pretty_printer():
    """Build a pretty printer."""
    pp = PrettyPrinterCollection()
    pp.add('node_hash_map', 'absl::node_hash_map', True, AbslNodeHashMapPrinter)
    pp.add('node_hash_set', 'absl::node_hash_set', True, AbslNodeHashSetPrinter)
    pp.add('flat_hash_map', 'absl::flat_hash_map', True, AbslFlatHashMapPrinter)
    pp.add('flat_hash_set', 'absl::flat_hash_set', True, AbslFlatHashSetPrinter)
    return pp


###################################################################################################
#
# Setup
#
###################################################################################################

# Register pretty-printers, replace existing mongo printers
gdb.printing.register_pretty_printer(gdb.current_objfile(), build_pretty_printer(), True)

print("GDB pretty-printers loaded")
