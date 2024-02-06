create table if not exists `users` (
    `id` integer not null primary key,
    `name` varchar(255) not null,
    `email` varchar(255) not null unique,
    `password` varchar(255) not null,
    `salt` varchar(255) not null,
    `created_at` timestamp not null default current_timestamp,
    `updated_at` timestamp not null default current_timestamp
);
create table if not exists `sessions` (
    `id` integer not null primary key,
    `user_id` integer not null,
    `token` varchar(255) not null unique,
    `is_valid` boolean not null default true,
    `created_at` timestamp not null default current_timestamp,
    `updated_at` timestamp not null default current_timestamp,
    foreign key (`user_id`) references `users` (`id`)
);
create trigger [UpdateLastTime]
    after update
    on ` sessions `
    for each row
begin
    update ` sessions `
    set ` updated_at ` = CURRENT_TIMESTAMP
    where RowId = old.RowId;
end;