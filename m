From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: Flashing USB2CAN devices under Linux and change the serial number
Date: Sat, 23 May 2015 10:06:28 +0200
Message-ID: <55603504.7030405@universalnet.at>
References: <0AD3D310E3BB3A45B6040EDF5C9897723F6A7188@VWAGWOXB0401.vw.vwg> <550D31DD.5090206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:35686 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757176AbbEWIGt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 23 May 2015 04:06:49 -0400
In-Reply-To: <550D31DD.5090206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Gediminas Simanskis <gediminas@8devices.com>

Sorry for the long delay.

I've updated the README.md file.

regards,
Bernd


Am 2015-03-21 um 09:54 schrieb Oliver Hartkopp:
> Hello Bernd,
>
> my colleague Eike wanted to change the USB2CAN serial numbers of his =
devices
> to have a proper differentiation between them.
>
> For that reason Gediminas provided on the 8device download section
>
>      http://www.8devices.com/usb2can#downloads
>
> This file:
>
> http://www.8devices.com/media/files/usb2can_eeproms_dfu_ED000100-ED00=
0226.zip
> (EEPROM images for devices with serial numbers ED000100-ED000226)
>
> The zip contains 37 dfu files named ED000xxx_1_0.dfu (xxx =3D differe=
nt numbers)
>
> As I was successful on my setup with flashing the firmware 1.5
>
>      http://www.8devices.com/media/files/usb2can_flash_1_5.zip
>
> Eike tried to flash the serial number dfu's in the same way which did=
n't work.
>
> The adapter was stuck in the bootloader and he wasn't able to flash i=
t.
> It turned out that this was a timing issue on his specific hardware a=
nd
> Gediminas suggested to *put an USB hub between the PC and the CAN ada=
pter*
> as some new high speed USB ports create problems with the timing.
>
> That made it work!
>
> So here are the command line options from Eike to flash the adapters.
>
> Firmware: dfu-util =96d 0483:df11 =96a 0 =96D usb2can_1_5.dfu
> SerialNo: dfu-util =96d 0483:df11 =96a 1 =96D E000xxx_1_0.dfu
>
> Together with the two attached patches applied on the dfu-util 0.8 at
>
>      http://sourceforge.net/p/dfu-util/dfu-util/ci/master/tree/
>
> we now have a working solution to flash firmware and serial numbers w=
ith Linux.
>
> Maybe you can update the README.md at
>
>      https://github.com/krumboeck/usb2can_firmware
>
> to add these infos.
>
> (Especially link to the attachments in this post e.g. on
> http://marc.info/?l=3Dlinux-can and change the URL to the dfu-util wh=
ich has
> moved from gitorious to sourceforge due to gitorious shutdown)
>
> Best regards,
> Oliver

