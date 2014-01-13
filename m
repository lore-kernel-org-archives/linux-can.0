From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/2] slcand: add flow control option
Date: Mon, 13 Jan 2014 19:01:40 +0100
Message-ID: <52D42A04.5060201@hartkopp.net>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:34937 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaAMSBm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 13:01:42 -0500
In-Reply-To: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, mkl@pengutronix.de

On 13.01.2014 09:54, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Add option '-t' to specify flow control type. Two types are
> supported: 'hw' - RTS/CTS and 'sw' - XON/XOFF.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
