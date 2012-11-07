From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] cangen: Support RTR frames with random or increment CAN IDs
Date: Wed, 07 Nov 2012 10:26:40 +0100
Message-ID: <2160499.dH8DEy9Phe@ws-stein>
References: <1352276048-21299-1-git-send-email-alexander.stein@systec-electronic.com> <509A24BC.5070505@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35880 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380Ab2KGJ0n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 04:26:43 -0500
In-Reply-To: <509A24BC.5070505@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can@vger.kernel.org

Hello Oliver,

On Wednesday 07 November 2012 10:07:08, Oliver Hartkopp wrote:
> just yesterday evening i was pondering about making the canfd branch of the
> can-utils the master branch ...
> 
> Due to added the CAN FD possibilities is also cleaned up the RTR sending
> which can be done randomly now too.
> 
> See the commit log at
> https://gitorious.org/linux-can/can-utils/commit/51c57c8445d5a0faef73f32fc9f5b772d4fde939
> 
> Please check out the canfd branch and see if cangen meets your requirements.

Yes, I'm fine with that. It's the same behavior as with my patch.

> The same with 'candump' ...
> There's a new '-x' option which prints extra message infos: RX/TX BRS ESI

Nice. This also is enough for my needs.

Thanks

Best regards,
Alexander

