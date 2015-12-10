From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] can-doc: Add hint about getting timestamps
Date: Thu, 10 Dec 2015 11:29:24 -0700
Message-ID: <20151210112924.4e8585f0@lwn.net>
References: <56546954.1070005@pengutronix.de>
	<1448373989-7241-1-git-send-email-rumpelsepp@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:53793 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbbLJS30 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 10 Dec 2015 13:29:26 -0500
In-Reply-To: <1448373989-7241-1-git-send-email-rumpelsepp@sevenbyte.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 24 Nov 2015 15:06:29 +0100
Stefan Tatschner <rumpelsepp@sevenbyte.org> wrote:

> This patch adds a hint about how to get timestamps of received
> CAN frames with ioctl(2). This hint has been applied to the
> former SocketCAN Documentation, but it got lost during mainlining
> the first bits and pieces to linux kernel.

Applied to the docs tree, thanks.

jon
