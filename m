From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Tue, 02 Dec 2014 16:17:47 +0100
Message-ID: <547DD81B.9000403@pengutronix.de>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SrMfGQ7vJblHil24HhjFAXUI7i1Of2Fdr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44066 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbaLBPRy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 10:17:54 -0500
In-Reply-To: <547DD608.5090403@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SrMfGQ7vJblHil24HhjFAXUI7i1Of2Fdr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2014 04:08 PM, Stephane Grosjean wrote:
>>>   drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955
>>> +++++++++++++++++++++++++++++
>>>   drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
>> Please don't create a header file, if it's only included once. Please
>> merge into the correct .c file.
>=20
> Ok. So I merge both header files into the .c file. There will be only a=

> single (and big) pcan_usb_fd.c file.

Yes, we only want code in header files that's used in more than one .c fi=
le.

>> Please have a look the _all_ multi-byte values and check for endianess=
=2E
>>
>> Hint, you might want to fix the existing driver first:
>>
>> pcan_usb_core.c:863:60: warning: restricted __le16 degrades to integer=

>>
>> pcan_usb.c:322:34: warning: cast to restricted __le32
>>
>> pcan_usb.c:357:20: warning: cast to restricted __le16
>>
>> pcan_usb.c:382:28: warning: cast to restricted __le16
>>
>> pcan_usb.c:625:30: warning: cast to restricted __le32
>>
>> pcan_usb.c:635:30: warning: cast to restricted __le16
>>
>> pcan_usb_pro.c:158:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:158:28:    expected unsigned int [unsigned] [usertype]
>> <noident>
>> pcan_usb_pro.c:158:28:    got restricted __le32 [usertype] <noident>
>>
>> pcan_usb_pro.c:168:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:168:28:    expected unsigned int [unsigned] [usertype]
>> <noident>
>> pcan_usb_pro.c:168:28:    got restricted __le32 [usertype] <noident>
>>
>> pcan_usb_pro.c:176:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:176:28:    expected unsigned short [unsigned] [short]
>> [usertype] <noident>
>> pcan_usb_pro.c:176:28:    got restricted __le16 [usertype] <noident>
>>
>> pcan_usb_pro.c:182:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:182:28:    expected unsigned short [unsigned] [short]
>> [usertype] <noident>
>> pcan_usb_pro.c:182:28:    got restricted __le16 [usertype] <noident>
>>
>> pcan_usb_pro.c:184:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:184:28:    expected unsigned int [unsigned] [usertype]
>> <noident>
>> pcan_usb_pro.c:184:28:    got restricted __le32 [usertype] <noident>
>>
>> pcan_usb_pro.c:190:28: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:190:28:    expected unsigned short [unsigned] [short]
>> [usertype] <noident>
>> pcan_usb_pro.c:190:28:    got restricted __le16 [usertype] <noident>
>>
>> pcan_usb_pro.c:203:32: warning: incorrect type in assignment (differen=
t
>> base types)
>> pcan_usb_pro.c:203:32:    expected unsigned int [unsigned] [usertype]
>> <noident>
>> pcan_usb_pro.c:203:32:    got restricted __le32 [usertype] <noident>
>>
>> pcan_usb_pro.c:286:27: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:458:30: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:550:29: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:561:47: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:575:32: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:605:35: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:606:35: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:678:47: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:696:37: warning: cast to restricted __le32
>>
>> pcan_usb_pro.c:720:19: warning: cast to restricted __le16
>>
>>
>> Compile your kernel with "make C=3D1 CF=3D-D__CHECK_ENDIAN__", you nee=
t to
>> have the tool "sparse" install. On debian/ubuntu/... it's: "sudo
>> aptitude install sparse"
>=20
> Ok, I'll do it too. And I suppose I'll push these changes in a separate=

> patch too...

Yes, as this is a fix this should be done before doing any improvements.

>=20
>>>   3 files changed, 1271 insertions(+)
>>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
>>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.h
>>>
>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h
>>> b/drivers/net/can/usb/peak_usb/pcan_ucan.h
>>> new file mode 100644
>>> index 0000000..2223c05
>>> --- /dev/null
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
[...]

>>> +#define PUCAN_CMD_OPCODE_CHANNEL(c, o)    cpu_to_le16(((c) << 12) |
>>> ((o) & 0x3ff))
>> I'm not sure, but I think I don't like hiding of the cpu_to_le16.
>> Can you make this a static inline function?
>=20
> Ok. So I suppose I have to do the same (inline function making) for all=

> the other occurrences of "cpu_to_le16()"  in this file, right?

Yes, the function would have a return value of __le16 then.

[...]

>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> new file mode 100644
>>> index 0000000..3d392a8
>>> --- /dev/null
>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[...]

>>> +/* send PCAN-USB Pro FD commands synchronously */
>>> +static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void
>>> *cmd_tail)
>>> +{
>>> +    void *cmd_head =3D pcan_usb_fd_cmd_buffer(dev);
>>> +    int actual_length;
>>> +    int err, cmd_len;
>> cmd_len is a long (or ptrdiff_t), as it's the diff of two pointers.
>=20
> Ok. So it will be a "ptrdiff_t" .
>=20
>>
>>> +    u8 *packet_ptr;
>>> +    int p, n =3D 1, packet_len;
>>> +
>>> +    /* usb device unregistered? */
>>> +    if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * if a packet is not filled completely by commands, the command=

>>> list
>>> +     * is terminated with an "end of collection" record.
>>> +     */
>>> +    cmd_len =3D cmd_tail - cmd_head;
>>> +    if (cmd_len < PCAN_UFD_CMD_BUFFER_SIZE) {
>> What happens if cmd_len turns out to be 511?
>=20
> Well, it can't: "commands" are 64-bits records. The "end of record"
> "command" must be added when the list of commands doesn't fill the
> entire buffer content.
> Maybe it would be better to write:
>=20
>    if (cmdlen <=3D (PCAN_UFD_CMD_BUFFER_SIZE - sizeof(u64)) {
>=20
>=20
> instead. What's your opinion about that?

Yes, better.

>=20
>>
>>> +        memset(cmd_tail, 0xff, sizeof(u64));
>>> +        cmd_len +=3D sizeof(u64);
>>> +    }
>>> +
>>> +    packet_ptr =3D cmd_head;
>>> +
>>> +    /* firmware is not able to re-assemble 512 bytes buffer in
>>> full-speed */
>>> +    if ((dev->udev->speed !=3D USB_SPEED_HIGH) &&
>>> +        (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
>>> +        packet_len =3D PCAN_UFD_LOSPD_PKT_SIZE;
>>> +        n +=3D cmd_len / packet_len;
>>> +    } else {
>>> +        packet_len =3D cmd_len;
>>> +    }
>>> +
>>> +    for (p =3D 1; p <=3D n; p++) {
>> why not the usual, start at 0? (p =3D 0, p < n, p++), or even "i" :)
>=20
> Well ok no problemo...
>=20
>>
>>> +        err =3D usb_bulk_msg(dev->udev,
>>> +                   usb_sndbulkpipe(dev->udev,
>>> +                           PCAN_USBPRO_EP_CMDOUT),
>>> +                   packet_ptr, packet_len,
>>> +                   &actual_length, PCAN_UFD_COMMAND_TIMEOUT);
>> Do you have to take care about actual_length? If not, you can pass NUL=
L
>> here AFAICS.
>=20
> Ok, you're right. This parameter can be NULL. Will be changed.
>=20
>>
>>> +        if (err) {
>>> +            netdev_err(dev->netdev,
>>> +                   "sending command failure: %d\n", err);
>>> +            break;
>>> +        }
>>> +
>>> +        packet_ptr +=3D packet_len;
>>> +    }
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static int pcan_usb_fd_set_bus(struct peak_usb_device *dev, u8 onoff=
)
>>                                                                 bool o=
n
>=20
> Humm... ok, but be advised that this change will have some side-effects=

> on the other existing files (pcan_usb_core.h, pcan_usb.c and
> pcan_usb_pro.c should be modified accordingly).

Okay, I haven't checked this. Keep it an u8 then.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SrMfGQ7vJblHil24HhjFAXUI7i1Of2Fdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfdgbAAoJECte4hHFiupUH2MP/R+hghB693GeCEMXHu+PcgpE
GhxjMu2cSjBplWDApRxzJqd84AUVmNFNxwHJMXBcavO5Rwm2sIcEBLGt090CRV/Z
E3m/y1UiURr9XE7zRHw/MKk8RsLDwVQWNmn8Vh+IZNmUwjw6Zdw4RWw+y5bh07ZH
1SUoy7X7pXd2j0Q3FXF8y91EngcOFU0g9Lc0A/B/2Cfh17jQcpRyHqmatussBf5h
CkPOBOgQFd0PWPJuh6CeT+sCWrOpz0WeRRn6ndQIOYrGdfnRBsJIWo6RJLnTf8Ow
FcH7ZI1f/fFuqKszVNY+Bm/uYJ2q+jOhO5Wdlry/e69DA04Q36CuLJZmcyb/EzHR
ox42mJdOzfe21LDkvw/3SmMeVwOPE9WvcQxjg+mvnNwCYQj3OtAN70o7dmdL0KKZ
gVIX5iL97SJ5NIO3xwJmCocJsrPPUZwxxYwMHXdDg7UPduZOcAeQYkmdoavcC7OD
Qk4972XGnNlvPzKdutEHITmVR0uReof+F7fc08nJUtwaY3HJz6kDr/sRcD4Qi3jS
k5iwIWYh/R6BSE+9cjRari85V7CpXtOwf7TczTHePL994wGJh8zdGYH4lZM82uyE
2UM4iwJ2zcQRVE/s/fkRVDoxlFW8VtJASzleQw0TDtTdpAou0QSlTLzwpsoiB5co
3SNzVvT1ik6wlpXUyiGT
=x9Dm
-----END PGP SIGNATURE-----

--SrMfGQ7vJblHil24HhjFAXUI7i1Of2Fdr--
