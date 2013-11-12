From: swapnil <patilswa@gmail.com>
Subject: Re: AW: Need support J1939 protocol support to my kernel (v3.8 on BeagleBone Black)
Date: Tue, 12 Nov 2013 01:10:04 +0000 (UTC)
Message-ID: <loom.20131112T015933-695@post.gmane.org>
References: <zarafa.5281024a.0b28.43b8b0d35b442ecc@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46315 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab3KLBPF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 11 Nov 2013 20:15:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Vg2ZL-0003Uk-Aj
	for linux-can@vger.kernel.org; Tue, 12 Nov 2013 02:15:03 +0100
Received: from c-98-212-86-243.hsd1.in.comcast.net ([98.212.86.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2013 02:15:03 +0100
Received: from patilswa by c-98-212-86-243.hsd1.in.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2013 02:15:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Luxen <mluxen <at> gmx.net> writes:

>=20
> Hello Swapnil,
>=20
> I've success with building the J1939 stack on my BBB based on Debian =
using=20
these steps:
>=20
> git clone git://gitorious.org/linux-can/can-utils.git
> cd can-utils
> --- get J1939 stuff ---
> git remote add j1939 git://gitorious.org/~kurt-vd/linux-can/linux-can=
-
j1939.git
> git remote update j1939
> --- depending on kernel ---
> git merge j1939/v3.6
> ...or=E2=80=A6
> git merge j1939/v3.8

git merge j1939/j1939-v3.8
after this step=20
ubuntu@arm:~/BBB/can-utils$ git merge j1939/j1939-v3.8
error: The following untracked working tree files would be overwritten =
by=20
merge:
        .mailmap
        COPYING
        CREDITS
        Documentation/.gitignore
        Documentation/00-INDEX
        Documentation/ABI/README
        Documentation/ABI/obsolete/sysfs-bus-usb
        Documentation/ABI/obsolete/sysfs-class-rfkill
        Documentation/ABI/obsolete/sysfs-driver-hid-roccat-koneplus
        Documentation/ABI/removed/devfs
        Documentation/ABI/removed/dv1394
        Documentation/ABI/removed/o2cb
        Documentation/ABI/removed/raw1394
        Documentation/ABI/removed/video1394
        Documentation/ABI/stable/firewire-cdev
        Documentation/ABI/stable/o2cb
        Documentation/ABI/stable/syscalls
        Documentation/ABI/stable/sysfs-acpi-pmprofile
        Documentation/ABI/stable/sysfs-bus-firewire
        Documentation/ABI/stable/sysfs-bus-xen-backend
        Documentation/ABI/stable/sysfs-class-backlight
        Documentation/ABI/stable/sysfs-class-rfkill
        Documentation/ABI/stable/sysfs-class-ubi
        Documentation/ABI/stable/sysfs-devices-node
        Documentation/ABI/stable/sysfs-devices-system-xen_memory
        Documentation/ABI/stable/sysfs-driver-qla2xxx
        Documentation/ABI/stable/sysfs-driver-usb-usbtmc
        Documentation/ABI/stable/sysfs-firmware-efi-vars
        Documentation/ABI/stable/sysfs-module
        Documentation/ABI/stable/thermal-notification
        Documentation/ABI/stable/vdso
        Documentation/ABI/testing/configfs-spear-pcie-gadget
        Documentation/ABI/testing/debugfs-ec
        Documentation/ABI/testing/debugfs-ideapad
        Documentation/ABI/testing/debugfs-pktcdvd
        Documentation/ABI/testing/evm
        Documentation/ABI/testing/ima_policy
        Documentation/ABI/testing/procfs-diskstats
        Documentation/ABI/testing/pstore
        Documentation/ABI/testing/sysfs-ata
        Documentation/ABI/testing/sysfs-block
        Documentation/ABI/testing/sysfs-block-zram
        Documentation/ABI/testing/sysfs-bus-bcma
        Documentation/ABI/testing/sysfs-bus-css
        Documentation/ABI/testing/sysfs-bus-i2c-devices-fsa9480
        Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
        Documentation/ABI/testing/sysfs-bus-media
        Documentation/ABI/testing/sysfs-bus-pci
        Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
        Documentation/ABI/testing/sysfs-bus-pci-drivers-ehci_hcd
        Documentation/ABI/testing/sysfs-bus-rbd
        Documentation/ABI/testing/sysfs-bus-umc
        Documentation/ABI/testing/sysfs-bus-usb
        Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
        Documentation/ABI/testing/sysfs-c2port
        Documentation/ABI/testing/sysfs-class
        Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
        Documentation/ABI/testing/sysfs-class-bdi
        Documentation/ABI/testing/sysfs-class-devfreq
        Documentation/ABI/testing/sysfs-class-lcd
        Documentation/ABI/testing/sysfs-class-led
        Documentation/ABI/testing/sysfs-class-mtd
        Documentation/ABI/testing/sysfs-class-net-batman-adv
        Documentation/ABI/testing/sysfs-class-net-mesh
        Documentation/ABI/testing/sysfs-class-pktcdvd
        Documentation/ABI/testing/sysfs-class-power
        Documentation/ABI/testing/sysfs-class-regulator
        Documentation/ABI/testing/sysfs-class-rtc-rtc0-device-
rtc_calibration
        Documentation/ABI/testing/sysfs-class-scsi_host
        Documentation/ABI/testing/sysfs-class-uwb_rc
        Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc
        Documentation/ABI/testing/sysfs-dev
        Documentation/ABI/testing/sysfs-devices
        Documentation/ABI/testing/sysfs-devices-memory
        Documentation/ABI/testing/sysfs-devices-mmc
        Documentation/ABI/testing/sysfs-devices-platform-_UDC_-gadget
        Documentation/ABI/testing/sysfs-devices-platform-docg3
        Documentation/ABI/testing/sysfs-devices-power
        Documentation/ABI/testing/sysfs-devices-system-cpu
        Documentation/ABI/testing/sysfs-devices-system-ibm-rtl
        Documentation/ABI/testing/sysfs-driver-hid
        Documentation/ABI/testing/sysfs-driver-hid-logitech-lg4ff
        Documentation/ABI/testing/sysfs-driver-hid-multitouch
        Documentation/ABI/testing/sysfs-driver-hid-picolcd
        Documentation/ABI/testing/sysfs-driver-hid-prodikeys
        Documentation/ABI/testing/sysfs-driver-hid-roccat-arvo
        Documentation/ABI/testing/sysfs-driver-hid-roccat-isku
        Documentation/ABI/testing/sysfs-driver-hid-roccat-kone
        Documentation/ABI/testing/sysfs-driver-hid-roccat-koneplus
        Documentation/ABI/testing/sysfs-driver-hid-roccat-kovaplus
        Docume
Aborting

didn't understand ??

what is the next step

>=20
> Regards
> Mike
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von:	Swapnil Patil <patilswa <at> gmail.com>
> Gesendet:	Mo 11.11.2013 16:46
> Betreff:	Need support J1939 protocol support to my kernel (v3.8 on=20
BeagleBone Black)
> An:	linux-can <at> vger.kernel.org;=20
> > Hi Kurt,
> >=20
> >              Thanks for your reply.
> > I am using Begalbone Black with Ubuntu 13.04
> > I am able to transmit the RAW and extended can message over the can
> > bus using can utility
> > Now I want to use  J1939 stack.
> > I downloaded the
> > Linux-can-can-j1939-modules and Linux-can-iproute2-j1939  and tried=
 to
> > build them but it failed
> >=20
> > Log of iproute2-j1939$ make
> >=20
> > make[1]: Entering directory `/home/ubuntu/BBB/iproute2-j1939/misc'
> > gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include
> > -DRESOLVE_HOSTNAM -DLIBDIR=3D\"/usr/lib/\" -I  -o arpdarpd.c
> > ../lib/libnetlink.a ../lib/libutil.-ldb -lpthread
> > gcc: error: arpd: No such file or directory
> >=20
> > Log of can-j1939-modules: make
> > /home/ubuntu/BBB/can-j1939-modules/net/can/j1939/rtnl.c:232:25: err=
or:
> > =C3=A2struct netlink_skb_parms=C3=A2 has no member named=C3=A2pid=C3=
=A2
> > /
> >=20
> >       If someone already build this on Begalbone black with ubuntu
> > 13.04 or angstrom kernel Please add the steps
> >=20
> > Thanks
> > Swapnil
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20



