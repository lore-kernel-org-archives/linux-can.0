From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 3 Aug 2017 09:39:19 +0200
Message-ID: <8e1434ab-68dc-d9a4-69f1-3732b39d7865@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cp2Bjr5Dv2Gr33uMtFR2dFXr58JifV8Vw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43405 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbdHCHj1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2017 03:39:27 -0400
In-Reply-To: <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cp2Bjr5Dv2Gr33uMtFR2dFXr58JifV8Vw
Content-Type: multipart/mixed; boundary="lRtIIbx5i02vgkVPmDXv3I8aV9s7lD5BB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <8e1434ab-68dc-d9a4-69f1-3732b39d7865@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
In-Reply-To: <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>

--lRtIIbx5i02vgkVPmDXv3I8aV9s7lD5BB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 07:03 AM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> Hello,
>>
>> while reviwing and cleaning up the j1939 stack I digged a bit deeper i=
nto
>> af_can and raw implementation.
>>
>> The first patch adds a missing error check and will probably go into -=
stable.
>=20
> ack.
> I'm currently working on an additional missing check for register of=20
> netdev notifier ...
>=20
>> Patches 2-8 change some struct and variable names, making the code mor=
e
>> readble, IMHO.
>=20
> I'm not convinced on this part.
> Where have you seen, that naming variables identical to the structs is =

> common or better readable?

More readable than 1 and 2 character variable names at least :)

>> Patch 9 removed the need for struct raw_sock::ifindex from the raw soc=
k, by
>> using struct sock::sk_bound_dev_if from the generic socket structure.
>=20
> Have a bad feeling on that - will comment later.

Ok

>> Patch 10: Checks if can_family is AF_CAN in raw's bind function.
> fine.
>=20
>> Patch 11: Cleans up the newly integrated CAN net namespace support.
>=20
> need to review
>=20
>> Patches 13-14: Where to put the per device protocol specific memory? a=
f_can
>> allocated it's memory during a netdev_notifier call, life cycle proves=
 to be
>> rather complicated (see remove_on_zero_entries, etc...), adding the j1=
939
>> memory makes it even more compilcated. So I decided to allocate the me=
mory
>> during the allocation if net_device. And this seems to work. More deta=
ils in
>> the individual patches.
>=20
> 'Seems to work' sounds frightening. There was a racy reason to have tha=
t=20
> implementation as-is. Although this approach sounds interesting. Need t=
o=20
> review too.

This is the callstack, when unplugging a USB device:

> [   53.144726] [<c0016cfc>] (unwind_backtrace) from [<c0013d04>] (show_=
stack+0x18/0x1c)
> [   53.152692] [<c0013d04>] (show_stack) from [<bf016510>] (can_rx_unre=
gister+0x68/0x1c0 [can])
> [   53.161366] [<bf016510>] (can_rx_unregister [can]) from [<bf01f0c0>]=
 (raw_disable_filters+0x44/0x60 [can_raw])
> [   53.171586] [<bf01f0c0>] (raw_disable_filters [can_raw]) from [<bf01=
f16c>] (raw_notifier+0x90/0x11c [can_raw])
> [   53.181799] [<bf01f16c>] (raw_notifier [can_raw]) from [<c0042000>] =
(notifier_call_chain+0x64/0xa4)
> [   53.191038] [<c0042000>] (notifier_call_chain) from [<c0042068>] (ra=
w_notifier_call_chain+0x1c/0x24)
> [   53.200389] [<c0042068>] (raw_notifier_call_chain) from [<c03bc3c0>]=
 (call_netdevice_notifiers+0x14/0x1c)
> [   53.210153] [<c03bc3c0>] (call_netdevice_notifiers) from [<c03bf634>=
] (rollback_registered_many+0x1a8/0x358)
> [   53.220180] [<c03bf634>] (rollback_registered_many) from [<c03bf82c>=
] (rollback_registered+0x48/0x68)
> [   53.229587] [<c03bf82c>] (rollback_registered) from [<c03bf8e0>] (un=
register_netdevice_queue+0x94/0xb0)
> [   53.239280] [<c03bf8e0>] (unregister_netdevice_queue) from [<c03bf91=
c>] (unregister_netdev+0x20/0x28)
> [   53.248693] [<c03bf91c>] (unregister_netdev) from [<bf011268>] (gs_u=
sb_disconnect+0x4c/0x7c [gs_usb])
> [   53.258112] [<bf011268>] (gs_usb_disconnect [gs_usb]) from [<c03515b=
0>] (usb_unbind_interface+0x80/0x1b4)
> [   53.267872] [<c03515b0>] (usb_unbind_interface) from [<c0324e00>] (d=
evice_release_driver_internal+0x124/0x1b4)
> [   53.278062] [<c0324e00>] (device_release_driver_internal) from [<c03=
23bb8>] (bus_remove_device+0xf0/0x124)
> [   53.287902] [<c0323bb8>] (bus_remove_device) from [<c03209b0>] (devi=
ce_del+0x210/0x2c8)
> [   53.296089] [<c03209b0>] (device_del) from [<c035023c>] (usb_disable=
_device+0xa4/0x224)
> [   53.304275] [<c035023c>] (usb_disable_device) from [<c034826c>] (usb=
_disconnect+0x90/0x17c)
> [   53.312801] [<c034826c>] (usb_disconnect) from [<c0349000>] (hub_eve=
nt+0x524/0xf74)
> [   53.320632] [<c0349000>] (hub_event) from [<c0039548>] (process_one_=
work+0x344/0x684)
> [   53.328653] [<c0039548>] (process_one_work) from [<c003ac7c>] (worke=
r_thread+0x2b4/0x410)
> [   53.337013] [<c003ac7c>] (worker_thread) from [<c00407c8>] (kthread+=
0x134/0x154)
> [   53.344589] [<c00407c8>] (kthread) from [<c000fa6c>] (ret_from_fork+=
0x14/0x28)

The raw protocol is teared down within the unregister_netdev() via a
call_netdevice_notifiers()...

> [   53.423328] [<c0016cfc>] (unwind_backtrace) from [<c0013d04>] (show_=
stack+0x18/0x1c)
> [   53.434197] [<c0013d04>] (show_stack) from [<c03e4a5c>] (netdev_rele=
ase+0x18/0x3c)
> [   53.445085] [<c03e4a5c>] (netdev_release) from [<c031fac8>] (device_=
release+0x64/0x9c)
> [   53.456348] [<c031fac8>] (device_release) from [<c048a904>] (kobject=
_put+0xd8/0x1d8)
> [   53.467330] [<c048a904>] (kobject_put) from [<bf011278>] (gs_usb_dis=
connect+0x5c/0x7c [gs_usb])
> [   53.479362] [<bf011278>] (gs_usb_disconnect [gs_usb]) from [<c03515b=
0>] (usb_unbind_interface+0x80/0x1b4)
> [   53.492137] [<c03515b0>] (usb_unbind_interface) from [<c0324e00>] (d=
evice_release_driver_internal+0x124/0x1b4)
> [   53.505308] [<c0324e00>] (device_release_driver_internal) from [<c03=
23bb8>] (bus_remove_device+0xf0/0x124)
> [   53.518221] [<c0323bb8>] (bus_remove_device) from [<c03209b0>] (devi=
ce_del+0x210/0x2c8)
> [   53.529664] [<c03209b0>] (device_del) from [<c035023c>] (usb_disable=
_device+0xa4/0x224)
> [   53.540867] [<c035023c>] (usb_disable_device) from [<c034826c>] (usb=
_disconnect+0x90/0x17c)
> [   53.560981] [<c0349000>] (hub_event) from [<c0039548>] (process_one_=
work+0x344/0x684)
> [   53.569453] [<c0039548>] (process_one_work) from [<c003ac7c>] (worke=
r_thread+0x2b4/0x410)
> [   53.578303] [<c003ac7c>] (worker_thread) from [<c00407c8>] (kthread+=
0x134/0x154)
> [   53.586337] [<c00407c8>] (kthread) from [<c000fa6c>] (ret_from_fork+=
0x14/0x28)

=2E..while the netdev is finally discarded via the kobject_put later on.

> I'm currently pretty busy at work.

That's my world, too :)

> Please to not push these things without my ACK (as we had it with the=20
> namespace support where I crashed my easter holiday to fix/implement al=
l=20
> the missing stuff to fit the merge window).

I'm on holidays too, SHA2017. If someone wants so meet me in person and
drink a mate or beer contact me.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lRtIIbx5i02vgkVPmDXv3I8aV9s7lD5BB--

--cp2Bjr5Dv2Gr33uMtFR2dFXr58JifV8Vw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmC0ycACgkQHv7KIOw4
HPZxUgf/c8lAQv1JJTJz3NVKuoOKMc7jIPz1cZHG1XcBwAGcLOKKNzr5CPPN4Q5I
1JyMgBytu8o5NjUx275bGD0LeynX7RaFv6iPfkbR6+fNpUnvZYNqqIBFmKwCCTUe
cfD99R9QATcFn5s+wT1blYBA+RUfYCwwNa676TLr9MkncWbSGAXe69W6mzU3hRoC
WarNoQfPURlhqY919SCLhNJMeoyMcDiAPTsB8FZ2JBGIgSBfiRRLvqJVAfMIIRGO
yjNP/tdSjHoKgpAMAZvb35gotrYNifZAZJLB7RIkwD1RD42CELOn/w7yJdSp3srx
igbgqRe6USumj0kytF+CR5Aw6UQuNQ==
=18pF
-----END PGP SIGNATURE-----

--cp2Bjr5Dv2Gr33uMtFR2dFXr58JifV8Vw--
