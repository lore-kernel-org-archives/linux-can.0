From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 0/2] Error message clean-ups for Renesas R-Car CAN driver
Date: Sat, 20 Jun 2015 03:49:25 +0300
Message-ID: <1593397.kKIHxKLe5s@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33128 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbFTAt3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Jun 2015 20:49:29 -0400
Received: by lbbvz5 with SMTP id vz5so32992609lbb.0
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2015 17:49:27 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's the set of 2 patches against Marc Kleine-Budde's 'linux-can.git'
repo plus 3 fix patches just posted; they are small error message cleanups for
the Renesas R-Car CAN driver.

[1/2] rcar_can: print request_irq() error code
[2/2] rcar_can: unify error messages

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
