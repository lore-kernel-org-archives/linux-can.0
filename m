Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206EC55ABD
	for <linux-can@archiver.kernel.org>; Thu, 12 Nov 2020 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BBF22201
	for <linux-can@archiver.kernel.org>; Thu, 12 Nov 2020 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKLSFL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:05:11 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:48734 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKLSFL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:05:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 6830DFFAB0
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yf42neFHJREE for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:05:09 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 16/16] can: ems_usb: Enable CPC-USB/FD support
Date:   Thu, 12 Nov 2020 19:03:46 +0100
Message-Id: <20201112180346.29070-17-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

By adding the device product id to the device table CPC-USB/FD is 
supported

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index b94364d8f390..36faec167cbb 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -301,10 +301,11 @@ struct __packed ems_cpc_msg {
 };
 
 /* Table of devices that work with this driver
- * NOTE: This driver supports only CPC-USB/ARM7 (LPC2119) yet.
+ * This driver supports CPC-USB/ARM7 and CPC-USB/FD
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
