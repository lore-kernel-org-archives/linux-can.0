From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Flashing USB2CAN devices under Linux and change the serial number
Date: Sat, 21 Mar 2015 09:54:53 +0100
Message-ID: <550D31DD.5090206@hartkopp.net>
References: <0AD3D310E3BB3A45B6040EDF5C9897723F6A7188@VWAGWOXB0401.vw.vwg>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000202020301020202060300"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:22256 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbCUIzG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2015 04:55:06 -0400
In-Reply-To: <0AD3D310E3BB3A45B6040EDF5C9897723F6A7188@VWAGWOXB0401.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Gediminas Simanskis <gediminas@8devices.com>

This is a multi-part message in MIME format.
--------------000202020301020202060300
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hello Bernd,

my colleague Eike wanted to change the USB2CAN serial numbers of his devices
to have a proper differentiation between them.

For that reason Gediminas provided on the 8device download section

	http://www.8devices.com/usb2can#downloads

This file:

http://www.8devices.com/media/files/usb2can_eeproms_dfu_ED000100-ED000226.zip
(EEPROM images for devices with serial numbers ED000100-ED000226)

The zip contains 37 dfu files named ED000xxx_1_0.dfu (xxx = different numbers)

As I was successful on my setup with flashing the firmware 1.5

	http://www.8devices.com/media/files/usb2can_flash_1_5.zip

Eike tried to flash the serial number dfu's in the same way which didn't work.

The adapter was stuck in the bootloader and he wasn't able to flash it.
It turned out that this was a timing issue on his specific hardware and
Gediminas suggested to *put an USB hub between the PC and the CAN adapter*
as some new high speed USB ports create problems with the timing.

That made it work!

So here are the command line options from Eike to flash the adapters.

Firmware: dfu-util –d 0483:df11 –a 0 –D usb2can_1_5.dfu
SerialNo: dfu-util –d 0483:df11 –a 1 –D E000xxx_1_0.dfu

Together with the two attached patches applied on the dfu-util 0.8 at

	http://sourceforge.net/p/dfu-util/dfu-util/ci/master/tree/

we now have a working solution to flash firmware and serial numbers with Linux.

Maybe you can update the README.md at

	https://github.com/krumboeck/usb2can_firmware

to add these infos.

(Especially link to the attachments in this post e.g. on
http://marc.info/?l=linux-can and change the URL to the dfu-util which has
moved from gitorious to sourceforge due to gitorious shutdown)

Best regards,
Oliver

--------------000202020301020202060300
Content-Type: text/x-patch;
 name="0001-dfu-util-remove-vendor-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-dfu-util-remove-vendor-check.patch"

From 84b3810c5af45185a7d09b771c2378c59fefa653 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 30 Jan 2015 22:29:22 +0100
Subject: [PATCH 1/2] dfu-util: remove vendor check

To flash the 8devices.com USB2CAN adapter we need to remove the vendor check.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 src/main.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/src/main.c b/src/main.c
index acaed2f..67da6d9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -249,8 +249,6 @@ int main(int argc, char **argv)
 	int fd;
 	const char *dfuse_options = NULL;
 	int detach_delay = 5;
-	uint16_t runtime_vendor;
-	uint16_t runtime_product;
 
 	memset(&file, 0, sizeof(file));
 
@@ -417,8 +415,6 @@ int main(int argc, char **argv)
 
 		/* FIXME: check if the selected device really has only one */
 
-		runtime_vendor = dfu_root->vendor;
-		runtime_product = dfu_root->product;
 
 		printf("Claiming USB DFU Runtime Interface...\n");
 		if (libusb_claim_interface(dfu_root->dev_handle, dfu_root->interface) < 0) {
@@ -517,13 +513,6 @@ int main(int argc, char **argv)
 		if (ret || !dfu_root->dev_handle) {
 			errx(EX_IOERR, "Cannot open device");
 		}
-	} else {
-		/* we're already in DFU mode, so we can skip the detach/reset
-		 * procedure */
-		/* If a match vendor/product was specified, use that as the runtime
-		 * vendor/product, otherwise use the DFU mode vendor/product */
-		runtime_vendor = match_vendor < 0 ? dfu_root->vendor : match_vendor;
-		runtime_product = match_product < 0 ? dfu_root->product : match_product;
 	}
 
 dfustate:
@@ -649,16 +638,6 @@ status_again:
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
-- 
2.1.4


--------------000202020301020202060300
Content-Type: text/x-patch;
 name="0002-dfu-util-change-erase-process.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-dfu-util-change-erase-process.patch"

From 4d951839578f04b01ecea3185fad6a72b488ba18 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 30 Jan 2015 22:32:14 +0100
Subject: [PATCH 2/2] dfu-util: change erase process

This patch is based on a hunk provided at
http://lists.gnumonks.org/pipermail/dfu-util/attachments/20140124/1abbc049/attachment.bin

I don't know what's the idea behind - but it is needed due to the documentation
to flash the USB2CAN adapter here:
https://github.com/krumboeck/usb2can_firmware

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 src/dfuse.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/src/dfuse.c b/src/dfuse.c
index fce29fe..5741a71 100644
--- a/src/dfuse.c
+++ b/src/dfuse.c
@@ -387,11 +387,18 @@ int dfuse_dnload_element(struct dfu_if *dif, unsigned int dwElementAddress,
 			dwElementAddress + dwElementSize - 1);
 	}
 
+	for (p = 0; p < (int)dwElementSize;) {
+		unsigned int address = dwElementAddress + p;
+		segment = find_segment(mem_layout, address);
+		if ((segment->memtype & DFUSE_ERASABLE) && !dfuse_mass_erase) {
+			dfuse_special_command(dif, address, ERASE_PAGE);
+		}
+		p = p + segment->pagesize;
+	}
+
 	dfu_progress_bar("Download", 0, 1);
 
 	for (p = 0; p < (int)dwElementSize; p += xfer_size) {
-		int page_size;
-		unsigned int erase_address;
 		unsigned int address = dwElementAddress + p;
 		int chunk_size = xfer_size;
 
@@ -400,35 +407,11 @@ int dfuse_dnload_element(struct dfu_if *dif, unsigned int dwElementAddress,
 			errx(EX_IOERR, "Page at 0x%08x is not writeable",
 				address);
 		}
-		page_size = segment->pagesize;
 
 		/* check if this is the last chunk */
 		if (p + chunk_size > (int)dwElementSize)
 			chunk_size = dwElementSize - p;
 
-		/* Erase only for flash memory downloads */
-		if ((segment->memtype & DFUSE_ERASABLE) && !dfuse_mass_erase) {
-			/* erase all involved pages */
-			for (erase_address = address;
-			     erase_address < address + chunk_size;
-			     erase_address += page_size)
-				if ((erase_address & ~(page_size - 1)) !=
-				    last_erased_page)
-					dfuse_special_command(dif,
-							      erase_address,
-							      ERASE_PAGE);
-
-			if (((address + chunk_size - 1) & ~(page_size - 1)) !=
-			    last_erased_page) {
-				if (verbose > 2)
-					printf(" Chunk extends into next page,"
-					       " erase it as well\n");
-				dfuse_special_command(dif,
-						      address + chunk_size - 1,
-						      ERASE_PAGE);
-			}
-		}
-
 		if (verbose) {
 			printf(" Download from image offset "
 			       "%08x to memory %08x-%08x, size %i\n",
-- 
2.1.4


--------------000202020301020202060300--
