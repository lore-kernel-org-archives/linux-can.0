From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] candump: Add timeout option if no message has been received
Date: Tue, 12 Feb 2013 15:05:04 +0100
Message-ID: <2883446.YiNPK9y0c4@ws-stein>
References: <1360665082-14256-1-git-send-email-alexander.stein@systec-electronic.com> <511A1EA1.7050607@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:47985 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932953Ab3BLOFH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 09:05:07 -0500
In-Reply-To: <511A1EA1.7050607@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tuesday 12 February 2013 11:51:13, Marc Kleine-Budde wrote:
> On 02/12/2013 11:31 AM, Alexander Stein wrote:
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> I get a new warning with your patch:
> 
> candump.c:231: warning: 'timeout_config' is used uninitialized in this
> function
> 
> I think the compiler is not smart enough :)

Yeah, I think that too :) Which version did you use?
Both gcc 4.6.3 and clang 3.1 didn't complain.

Regards,
Alexander


