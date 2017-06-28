From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: MCAN Registers Discrepancy
Date: Wed, 28 Jun 2017 16:49:06 -0500
Message-ID: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:34099 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdF1VtZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Jun 2017 17:49:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, b29396@freescale.com, socketcan@hartkopp.net

Hi,

When looking at the latest versions of the MCAN user manual it seems
that there is a discrepancy between the various BTR_XX_MASK and
BTR_XX_SHIFT values. For example BTR_TSEG2_MASK is set to 0xF and
BTR_TSEG2_SHIFT is 4. However, based on page 21 of the latest version of
the MCAN User Manual NTSEG2 starts at bit 0. Therefore, it should have a
shift value of 0. Also it is a 7 bit field so its mask should be 0x7F. I
see similar issues with FBTR_XXX_MASK values.

So the original driver mentioned it was based on rev version 3.1.0 of
the User Manual while the latest version publicly available is 3.2.12.
Since I don't see any current users of this driver in upstream I am
unsure if this is just a bug in the code or if the current values are
correct for older versions of the IP.

Does anyone have a copy of this older document available that they can
share? Or at the very least verify that the current values were correct
in older revisions of the MCAN IP? I need to make updates to the drivers
but I want to avoid breaking things for other people.

Latest version of the MCAN User Manual can be found at:
http://www.bosch-semiconductors.de/media/automotive_electronics/pdf_2/ipmodules_3/m_can_m_ttcan_1/mcan_users_manual_v3212.pdf
