From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Sat, 25 Jan 2014 12:04:41 +0100
Message-ID: <52E39A49.10205@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com> <52DFC08C.2040400@universalnet.at> <52DFD9B7.40300@pengutronix.de> <52E36208.3020100@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000706040300040601040705"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:9898 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaAYLEo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jan 2014 06:04:44 -0500
In-Reply-To: <52E36208.3020100@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706040300040601040705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.01.2014 08:04, Bernd Krumboeck wrote:

> 
> After some experiments I was able to flash the firmware with dfu-util under
> linux:
> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental
> 
> 

Hello Bernd,

many thanks - especially for the flash description above!

Two remarks to your dfu for Linux description:

change "./configure.sh" to "./configure"

A proper patch for removing the vendor check is attached, so that you can
link the patch in your description.

It should appear in this posting e.g. at http://marc.info/?l=linux-can like
the attachment from Gediminas:
http://marc.info/?l=linux-can&m=139036935703648&w=1

here: http://marc.info/?l=linux-can&m=139036935703648&q=p3

Btw. I was not able to update my adapter because it fails at different
percentages of the download - see below. I'll try with another usblib or
another Linux box.

Best regards,
Oliver

# dfu-util -d 0483:df11 -a 0 -D usb2can_1_5.dfu 
dfu-util 0.7

Copyright 2005-2008 Weston Schmidt, Harald Welte and OpenMoko Inc.
Copyright 2010-2012 Tormod Volden and Stefan Schmidt
This program is Free Software and has ABSOLUTELY NO WARRANTY
Please report bugs to dfu-util@lists.gnumonks.org

Deducing device DFU version from functional descriptor length
Opening DFU capable USB device...
ID 0483:df11
Run-time device DFU version 011a
Claiming USB DFU Runtime Interface...
Determining device status: state = dfuERROR, status = 10
dfuERROR, clearing status
dfu-util: WARNING: Runtime device already in DFU state ?!?
Claiming USB DFU Interface...
Setting Alternate Setting #0 ...
Determining device status: state = dfuIDLE, status = 0
dfuIDLE, continuing
DFU mode device DFU version 011a
Device returned transfer size 1024
DfuSe interface name: "Internal Flash 0"
file contains 1 DFU images
parsing DFU image 1
image for alternate setting 0, (1 elements, total size = 24584)
parsing element 1, address = 0x20006000, size = 24576
Download	[=========                ]  37%         9216 bytesdfu-util: dfuse_download: libusb_control_transfer returned -9
# _



--------------000706040300040601040705
Content-Type: text/x-diff;
 name="dfu-remove-vendor-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dfu-remove-vendor-check.patch"

diff --git a/src/main.c b/src/main.c
index 30a9bd8..516a460 100644
--- a/src/main.c
+++ b/src/main.c
@@ -655,16 +655,6 @@ status_again:
 		break;
 
 	case MODE_DOWNLOAD:
-		if (((file.idVendor  != 0xffff && file.idVendor  != runtime_vendor) ||
-		     (file.idProduct != 0xffff && file.idProduct != runtime_product)) &&
-		    ((file.idVendor  != 0xffff && file.idVendor  != dfu_root->vendor) ||
-		     (file.idProduct != 0xffff && file.idProduct != dfu_root->product))) {
-			errx(EX_IOERR, "Error: File ID %04x:%04x does "
-				"not match device (%04x:%04x or %04x:%04x)",
-				file.idVendor, file.idProduct,
-				runtime_vendor, runtime_product,
-				dfu_root->vendor, dfu_root->product);
-		}
 		if (dfuse_device || dfuse_options || file.bcdDFU == 0x11a) {
 		        if (dfuse_do_dnload(dfu_root, transfer_size, &file,
 							dfuse_options) < 0)

--------------000706040300040601040705--
