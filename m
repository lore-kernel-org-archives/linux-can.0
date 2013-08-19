From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] linux/can: add explicit copyrights to can headers
Date: Mon, 19 Aug 2013 19:13:23 +0200
Message-ID: <52125233.8020508@hartkopp.net>
References: <1376858497-1700-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:42439 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab3HSRN3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2013 13:13:29 -0400
In-Reply-To: <1376858497-1700-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Urs Thuermann <urs.thuermann@volkswagen.de>, Wolfgang Grandegger <wg@grandegger.com>

On 18.08.2013 22:41, Uwe Kleine-K=C3=B6nig wrote:
> These files are copied to the source code of user space applications =
(in
> this case can-utils) and so it makes sense to mention explicitly thei=
r
> copyright. I added the terms of C code that was introduced in the sam=
e
> commit as these headers.
>=20
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Urs Thuermann <urs.thuermann@volkswagen.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx Uwe!

> Hello,
>=20
> I think it is necessary to get the Ack of the three people mentioned =
in
> the Cc: commit footers. @Wolfgang: I added a statement
>=20
>     The provided data structures and external interfaces from this co=
de
>     are not restricted to be used by software with a GPL compatible l=
icense.
>=20
> similar to the other can headers. Does that suit you?
>=20
> Best regards
> Uwe
>=20
>  include/uapi/linux/can/bcm.h     | 32 ++++++++++++++++++++++++++++++=
++
>  include/uapi/linux/can/error.h   | 32 ++++++++++++++++++++++++++++++=
++
>  include/uapi/linux/can/gw.h      | 32 ++++++++++++++++++++++++++++++=
++
>  include/uapi/linux/can/netlink.h | 11 +++++++++++
>  include/uapi/linux/can/raw.h     | 32 ++++++++++++++++++++++++++++++=
++
>  5 files changed, 139 insertions(+)
>=20
> diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bc=
m.h
> index 3ebe387..382251a 100644
> --- a/include/uapi/linux/can/bcm.h
> +++ b/include/uapi/linux/can/bcm.h
> @@ -7,6 +7,38 @@
>   * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + *    notice, this list of conditions and the following disclaimer i=
n the
> + *    documentation and/or other materials provided with the distrib=
ution.
> + * 3. Neither the name of Volkswagen nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this s=
oftware
> + *    without specific prior written permission.
> + *
> + * Alternatively, provided that this notice is retained in full, thi=
s
> + * software may be distributed under the terms of the GNU General
> + * Public License ("GPL") version 2, in which case the provisions of=
 the
> + * GPL apply INSTEAD OF those given above.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by modules with a GPL compatible li=
cense.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
>   */
> =20
>  #ifndef CAN_BCM_H
> diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/=
error.h
> index 7b7148b..b632045 100644
> --- a/include/uapi/linux/can/error.h
> +++ b/include/uapi/linux/can/error.h
> @@ -7,6 +7,38 @@
>   * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + *    notice, this list of conditions and the following disclaimer i=
n the
> + *    documentation and/or other materials provided with the distrib=
ution.
> + * 3. Neither the name of Volkswagen nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this s=
oftware
> + *    without specific prior written permission.
> + *
> + * Alternatively, provided that this notice is retained in full, thi=
s
> + * software may be distributed under the terms of the GNU General
> + * Public License ("GPL") version 2, in which case the provisions of=
 the
> + * GPL apply INSTEAD OF those given above.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by modules with a GPL compatible li=
cense.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
>   */
> =20
>  #ifndef CAN_ERROR_H
> diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.=
h
> index ae07bec..730c540 100644
> --- a/include/uapi/linux/can/gw.h
> +++ b/include/uapi/linux/can/gw.h
> @@ -7,6 +7,38 @@
>   * Copyright (c) 2011 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + *    notice, this list of conditions and the following disclaimer i=
n the
> + *    documentation and/or other materials provided with the distrib=
ution.
> + * 3. Neither the name of Volkswagen nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this s=
oftware
> + *    without specific prior written permission.
> + *
> + * Alternatively, provided that this notice is retained in full, thi=
s
> + * software may be distributed under the terms of the GNU General
> + * Public License ("GPL") version 2, in which case the provisions of=
 the
> + * GPL apply INSTEAD OF those given above.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by modules with a GPL compatible li=
cense.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
>   */
> =20
>  #ifndef CAN_GW_H
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/ca=
n/netlink.h
> index 14966dd..8bbb885 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -5,6 +5,17 @@
>   *
>   * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
>   *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the version 2 of the GNU General Public Lic=
ense
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by software with a GPL compatible l=
icense.
>   */
> =20
>  #ifndef CAN_NETLINK_H
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/ra=
w.h
> index a814062..c7d8c33 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -8,6 +8,38 @@
>   * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + *    notice, this list of conditions and the following disclaimer i=
n the
> + *    documentation and/or other materials provided with the distrib=
ution.
> + * 3. Neither the name of Volkswagen nor the names of its contributo=
rs
> + *    may be used to endorse or promote products derived from this s=
oftware
> + *    without specific prior written permission.
> + *
> + * Alternatively, provided that this notice is retained in full, thi=
s
> + * software may be distributed under the terms of the GNU General
> + * Public License ("GPL") version 2, in which case the provisions of=
 the
> + * GPL apply INSTEAD OF those given above.
> + *
> + * The provided data structures and external interfaces from this co=
de
> + * are not restricted to be used by modules with a GPL compatible li=
cense.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> + * DAMAGE.
>   */
> =20
>  #ifndef CAN_RAW_H
>=20

