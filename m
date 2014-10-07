From: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 1/2] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Tue, 7 Oct 2014 15:27:57 +0200
Message-ID: <20141007152757.405ea6ab@archvile>
References: <20141006131751.75823c82@archvile>
	<1412674205-23882-1-git-send-email-david@protonic.nl>
	<5433E7E0.4050007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:7665 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbaJGN1s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 09:27:48 -0400
In-Reply-To: <5433E7E0.4050007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>


Dear Marc,

On Tue, 07 Oct 2014 15:17:20 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/07/2014 11:30 AM, David Jander wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Applied to the rx-fifo branch. I can rebase the branch if you need e.g.
> v3.17....

Uh-oh! I meant to have comments on the idea more than apply immediately... I
thought a cautious "RFC" in the subject would do that ;-)

Never mind, there are still some bugs in that patch.... the
can_rx_fifo_mask_*() functions contain some 0U constants that need to change
to 0LLU. I think it is better you drop the current version for now...
I am currently debugging a new version of flexcan that uses these two patches,
to see if it works, but I'd like to have your (and other people's) opinion on
this whole idea before going too far into that direction...

Best regards,

-- 
David Jander
Protonic Holland.
