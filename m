From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-01-21
Date: Mon, 26 Jan 2015 15:24:43 -0800 (PST)
Message-ID: <20150126.152443.449462610794630865.davem@davemloft.net>
References: <1421876791-31014-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46308 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbbA0AoC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 19:44:02 -0500
In-Reply-To: <1421876791-31014-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 21 Jan 2015 22:46:30 +0100

> this is a pull request for v3.19, net/master, which consists of a single patch.
> 
> Viktor Babrian fixes the issue in the c_can dirver, that the CAN interface
> might continue to send frames after the interface has been shut down.

Pulled, thanks Marc.
