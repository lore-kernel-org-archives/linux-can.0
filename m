Return-Path: <SRS0=ufsH=EM=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4427C56201
	for <linux-can@archiver.kernel.org>; Fri,  6 Nov 2020 17:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A972072E
	for <linux-can@archiver.kernel.org>; Fri,  6 Nov 2020 17:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKFRLW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:11:22 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:44226 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgKFRLV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 926A4FFBCB
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4AUajoJs_Lwh for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:50 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 17/17] can: ems_usb: Made another struct packed. Enable CPC-USB/FD by adding it to the drivers device table
Date:   Fri,  6 Nov 2020 18:02:06 +0100
Message-Id: <20201106170206.32162-18-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 7ede3ac08ed5..087069f999e5 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -269,7 +269,7 @@ struct __packed cpc_can_error {
 /* Structure containing RX/TX error counter. This structure is used to request
  * the values of the CAN controllers TX and RX error counter.
  */
-struct cpc_can_err_counter {
+struct __packed cpc_can_err_counter {
 	u8 rx;
 	u8 tx;
 };
@@ -296,10 +296,11 @@ struct __packed ems_cpc_msg {
 };
 
 /* Table of devices that work with this driver
- * NOTE: This driver supports only CPC-USB/ARM7 (LPC2119) yet.
+ * This driver supports CPC-USB/ARM7 and CPC-USB/FD.
  */
 static struct usb_device_id ems_usb_table[] = {
 	{USB_DEVICE(USB_CPCUSB_VENDOR_ID, USB_CPCUSB_ARM7_PRODUCT_ID)},
+	{USB_DEVICE(USB_CPCUSB_VENDOR_ID, USB_CPCUSB_FD_PRODUCT_ID)},
 	{} /* Terminating entry */
 };
 
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
