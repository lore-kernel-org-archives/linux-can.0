From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 0/2] can: flexcan: upgrade the flexcan.c to support i.MX6
Date: Thu, 28 Jun 2012 16:21:33 +0800
Message-ID: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61075 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab2F1IVv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 04:21:51 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

The first patch is an incremental one basing on the "can: flexcan: use be32_to_cpup to handle the value of dt entry".

The second patch is inspired from your suggestion, it is a simple implementation and so far only add p1010 and imx6q in the support list. We can extend this list in a later time if it is necessary.


Regards,
Hui.


