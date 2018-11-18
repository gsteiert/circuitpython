/*
 * This file is part of the MicroPython project, http://micropython.org/
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2017 Glenn Ruben Bakke
 * Copyright (c) 2018 Artur Pacholec
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "py/objproperty.h"
#include "py/runtime.h"
#include "shared-bindings/bleio/Service.h"
#include "shared-bindings/bleio/UUID.h"

//| .. currentmodule:: bleio
//|
//| :class:`Service` -- BLE service
//| =========================================================
//|
//| Stores information about a BLE service and its characteristics.
//|

//| .. class:: Service(uuid, secondary=False)
//|
//|   Create a new Service object identified by the specified UUID.
//|   To mark the service as secondary, pass `True` as :py:data:`secondary`.
//|
//|   :param bleio.UUID uuid: The uuid of the service
//|   :param bool secondary: If the service is a secondary one
//|

//|   .. method:: add_characteristic(characteristic)
//|
//|     Appends the :py:data:`characteristic` to the list of this service's characteristics.
//|
//|      :param bleio.Characteristic characteristic: the characteristic to append
//|

//|   .. attribute:: characteristics
//|
//|     A `list` of `bleio.Characteristic` that are offered by this service. (read-only)
//|

//|   .. attribute:: uuid
//|
//|     The UUID of this service. (read-only)
//|
STATIC void bleio_service_print(const mp_print_t *print, mp_obj_t self_in, mp_print_kind_t kind) {
    bleio_service_obj_t *self = MP_OBJ_TO_PTR(self_in);

    mp_printf(print, "Service(uuid: 0x"HEX2_FMT""HEX2_FMT")",
        self->uuid->value[1], self->uuid->value[0]);
}

STATIC mp_obj_t bleio_service_make_new(const mp_obj_type_t *type, size_t n_args, size_t n_kw, const mp_obj_t *pos_args) {
    mp_arg_check_num(n_args, n_kw, 1, 1, true);
    bleio_service_obj_t *self = m_new_obj(bleio_service_obj_t);
    self->base.type = &bleio_service_type;
    self->device = NULL;
    self->char_list = mp_obj_new_list(0, NULL);
    self->handle = 0xFFFF;

    mp_map_t kw_args;
    mp_map_init_fixed_table(&kw_args, n_kw, pos_args + n_args);

    enum { ARG_uuid, ARG_secondary };
    static const mp_arg_t allowed_args[] = {
        { ARG_uuid, MP_ARG_OBJ, {.u_obj = mp_const_none} },
        { MP_QSTR_secondary, MP_ARG_KW_ONLY | MP_ARG_BOOL, {.u_bool = false} },
    };

    mp_arg_val_t args[MP_ARRAY_SIZE(allowed_args)];
    mp_arg_parse_all(n_args, pos_args, &kw_args, MP_ARRAY_SIZE(allowed_args), allowed_args, args);

    self->is_secondary = args[ARG_secondary].u_bool;

    const mp_obj_t uuid = args[ARG_uuid].u_obj;

    if (uuid == mp_const_none) {
        return MP_OBJ_FROM_PTR(self);
    }

    if (MP_OBJ_IS_TYPE(uuid, &bleio_uuid_type)) {
        self->uuid = MP_OBJ_TO_PTR(uuid);
    } else {
        nlr_raise(mp_obj_new_exception_msg_varg(&mp_type_ValueError,
                  translate("Invalid UUID parameter")));
    }

    return MP_OBJ_FROM_PTR(self);
}

STATIC mp_obj_t bleio_service_add_characteristic(mp_obj_t self_in, mp_obj_t characteristic_in) {
    bleio_service_obj_t *self = MP_OBJ_TO_PTR(self_in);
    bleio_characteristic_obj_t *characteristic = MP_OBJ_TO_PTR(characteristic_in);

    if (self->uuid->type == UUID_TYPE_128BIT) {
        characteristic->uuid->type = UUID_TYPE_128BIT;
        characteristic->uuid->uuid_vs_idx = self->uuid->uuid_vs_idx;
    }

    characteristic->service = self;

    mp_obj_list_append(self->char_list, characteristic);

    return mp_const_none;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_2(bleio_service_add_characteristic_obj, bleio_service_add_characteristic);

STATIC mp_obj_t bleio_service_get_characteristics(mp_obj_t self_in) {
    bleio_service_obj_t *self = MP_OBJ_TO_PTR(self_in);

    return self->char_list;
}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(bleio_service_get_characteristics_obj, bleio_service_get_characteristics);

const mp_obj_property_t bleio_service_characteristics_obj = {
    .base.type = &mp_type_property,
    .proxy = { (mp_obj_t)&bleio_service_get_characteristics_obj,
               (mp_obj_t)&mp_const_none_obj,
               (mp_obj_t)&mp_const_none_obj },
};

STATIC mp_obj_t bleio_service_get_uuid(mp_obj_t self_in) {
    bleio_service_obj_t *self = MP_OBJ_TO_PTR(self_in);

    return MP_OBJ_FROM_PTR(self->uuid);
}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(bleio_service_get_uuid_obj, bleio_service_get_uuid);

const mp_obj_property_t bleio_service_uuid_obj = {
    .base.type = &mp_type_property,
    .proxy = { (mp_obj_t)&bleio_service_get_uuid_obj,
               (mp_obj_t)&mp_const_none_obj,
               (mp_obj_t)&mp_const_none_obj },
};

STATIC const mp_rom_map_elem_t bleio_service_locals_dict_table[] = {
    { MP_ROM_QSTR(MP_QSTR_add_characteristic), MP_ROM_PTR(&bleio_service_add_characteristic_obj) },
    { MP_ROM_QSTR(MP_QSTR_characteristics),    MP_ROM_PTR(&bleio_service_characteristics_obj) },
    { MP_ROM_QSTR(MP_QSTR_uuid),               MP_ROM_PTR(&bleio_service_uuid_obj) },
};

STATIC MP_DEFINE_CONST_DICT(bleio_service_locals_dict, bleio_service_locals_dict_table);

const mp_obj_type_t bleio_service_type = {
    { &mp_type_type },
    .name = MP_QSTR_Service,
    .print = bleio_service_print,
    .make_new = bleio_service_make_new,
    .locals_dict = (mp_obj_dict_t*)&bleio_service_locals_dict
};
