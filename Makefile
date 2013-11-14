# See LICENSE for licensing information.

PROJECT = cowboy_request_id

# Dependencies.

DEPS = uuid fast_key
dep_uuid = https://github.com/avtobiff/erlang-uuid.git master
dep_fast_key = https://github.com/CamShaft/fast_key.git master

# Standard targets.

include erlang.mk
