const Camera = @This();

const std = @import("std");
const rl = @import("raylib");

position: @Vector(2, f32),
rotation: f32,

zoom: f32,
target_zoom: f32,

const move_speed = 5.0;
const zoom_speed = 1.15;
const zoom_lerp_speed = 12.0;

const min_zoom = 30.0;
const max_zoom = 400.0;

pub fn init(position: @Vector(2, f32)) Camera {
    return .{
        .position = position,
        .rotation = 0.0,
        .zoom = 100.0,
        .target_zoom = 100.0,
    };
}

pub fn update(self: *Camera, delta_time: f32) void {
    if (rl.IsKeyDown(rl.KEY_A) or rl.IsKeyDown(rl.KEY_LEFT)) {
        self.position[0] -= move_speed * delta_time;
    }

    if (rl.IsKeyDown(rl.KEY_D) or rl.IsKeyDown(rl.KEY_RIGHT)) {
        self.position[0] += move_speed * delta_time;
    }

    const scroll = rl.GetMouseWheelMove();

    if (scroll > 0.0) {
        self.target_zoom *= std.math.pow(
            f32,
            zoom_speed,
            scroll,
        );
    } else if (scroll < 0.0) {
        self.target_zoom /= std.math.pow(
            f32,
            zoom_speed,
            -scroll,
        );
    }

    self.target_zoom = std.math.clamp(
        self.target_zoom,
        min_zoom,
        max_zoom,
    );

    self.zoom = std.math.lerp(
        self.zoom,
        self.target_zoom,
        1.0 - @exp(-zoom_lerp_speed * delta_time),
    );
}

pub fn toRaylib(self: Camera) rl.Camera2D {
    const screen_width: f32 = @floatFromInt(rl.GetScreenWidth());
    const screen_height: f32 = @floatFromInt(rl.GetScreenHeight());

    return .{
        .target = .{
            .x = self.position[0],
            .y = self.position[1],
        },
        .offset = .{
            .x = screen_width * 0.5,
            .y = screen_height,
        },
        .rotation = self.rotation,
        .zoom = self.zoom,
    };
}
