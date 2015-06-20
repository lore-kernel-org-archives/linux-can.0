From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/3] Small fixes for Renesas R-Car CAN driver
Date: Sat, 20 Jun 2015 03:30:51 +0300
Message-ID: <2010452.WyFito6egU@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35797 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbbFTAaz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Jun 2015 20:30:55 -0400
Received: by labko7 with SMTP id ko7so83088030lab.2
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2015 17:30:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's the set of 3 patches against Marc Kleine-Budde's 'linux-can.git'
repo; they are small fixes for the Renesas R-Car CAN driver.

rcar_can: fix IRQ check
rcar_can: print signed IRQ #
rcar_can: fix typo in error message

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
