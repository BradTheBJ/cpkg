const std = @import("std");
const cpkgInit = @import("cpkgInit.zig");

pub fn main() !void {
    try cpkgInit.cpkgInit();
}

