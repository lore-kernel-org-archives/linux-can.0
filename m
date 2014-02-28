From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/7] can: flexcan: fix shutdown problems
Date: Fri, 28 Feb 2014 23:06:22 +0100
Message-ID: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43134 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaB1WGl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 17:06:41 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

this series fixes hanging systems when shutting down the flexcan core during
heavy bus load.

Probably most patches are candidates for stable.

Marc

