pub const Parallax = @This();

const std = @import("std");
const rl = @import("raylib");

backgrounds: [3]rl.Texture2D,
scrollings: [3]f32,

pub fn init(self: *Parallax) void {
    inline for (0..3) |i| {
        self.backgrounds[i] = rl.LoadTexture("assets/bg" ++ i ++ ".png");
        self.scrollings[i] = -(0.1 + 0.5 * i);
    }
}

pub fn update(self: *Parallax) void {
    inline for (&self.scrollings, self.backgrounds) |*scroll, background| {
        if (scroll <= -background.width * 2) scroll = 0;
        rl.DrawTextureEx(
            background,
            .{ .x = scroll, .y = 20 },
            .{},
            .{},
            rl.WHITE,
        );
    }
}
