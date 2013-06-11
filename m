From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] flexcan: Remove platform file
Date: Mon, 10 Jun 2013 23:12:58 -0300
Message-ID: <1370916778-4406-3-git-send-email-festevam@gmail.com>
References: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:52809 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3FKCUk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 22:20:40 -0400
Received: by mail-gg0-f170.google.com with SMTP id s5so353699ggc.1
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 19:20:39 -0700 (PDT)
In-Reply-To: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

As there are no more users of the flexcan platform file, let's remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/linux/can/platform/flexcan.h | 20 --------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 include/linux/can/platform/flexcan.h

diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/platform/flexcan.h
deleted file mode 100644
index 72b713a..0000000
-- 
1.8.1.2

