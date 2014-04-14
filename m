From: Steffen Rose <ro@emtas.de>
Subject: Error Active
Date: Mon, 14 Apr 2014 10:03:51 +0200
Message-ID: <15704970.EHNVEi1RO0@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52295 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbaDNIEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Apr 2014 04:04:35 -0400
Received: from lisa.localnet (unknown [192.168.0.254])
	by kolab3.emtas.de (Postfix) with ESMTPS id DD8E15EA91F
	for <linux-can@vger.kernel.org>; Mon, 14 Apr 2014 10:04:07 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I write a generic application, that should work with different socketca=
n driver implementations.=20
I know, there are different possibilities to get the CAN controller sta=
te. And I see, that different=20
implementation do not implement all of them.

What is the standard way to get the state change from Error Passive to =
Error Active?

My current way (in short incomplete form):

can_err_mask_t err_mask =3D CAN_ERR_FLAG | CAN_ERR_CRTL | CAN_ERR_PROT =
| CAN_ERR_BUSOFF;
setsockopt(mBSDSocket, SOL_CAN_RAW, CAN_RAW_ERR_FILTER, &err_mask, size=
of(err_mask));

got =3D read(mBSDSocket, &frame, sizeof(struct can_frame));
if (frame.can_id & CAN_ERR_FLAG) {
  if (frame.can_id & CAN_ERR_PROT) {
    if (frame.data[2] & CAN_ERR_PROT_ACTIVE) {

=3D> change to Error active

    }
  }
}

This will work with the Systec USB interface, but do not work with Peak=
, Beagle bone, EMS CPC.
I have seen the implementation in the can utils.

I know, the libsocketcan implements a different way. But I cannot extra=
ct the relevant parts.=20
And I think a have to poll the current state with it and I search an ev=
ent based mechanism.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Regards
Steffen Rose
www.emtas.de
