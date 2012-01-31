From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/12] pch_can: Change company name OKI SEMICONDUCTOR to LAPIS Semiconductor
Date: Tue, 31 Jan 2012 22:46:45 +0100
Message-ID: <1328046410-21392-8-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44855 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab2AaVrD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:47:03 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Tomoya MORINAGA <tomoya.rohm@gmail.com>

On October 1 in 2011,
    OKI SEMICONDUCTOR Co., Ltd. changed the company name in to LAPIS Semiconductor

Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/pch_can.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 6edc25e..2bb215e 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 1999 - 2010 Intel Corporation.
- * Copyright (C) 2010 OKI SEMICONDUCTOR CO., LTD.
+ * Copyright (C) 2010 LAPIS SEMICONDUCTOR CO., LTD.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
1.7.4.1

