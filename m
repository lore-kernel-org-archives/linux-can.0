From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] can-utils: AOSP build improvements
Date: Wed, 20 Feb 2013 09:43:58 +0100
Message-ID: <20130220084358.GB5486@vandijck-laurijssen.be>
References: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com>
 <5121E30E.1050305@pengutronix.de>
 <CAGm1_ks1qZkaE0UGMV2F9ooFrziMNb3JAtcqMW1AWX7VSP9Teg@mail.gmail.com>
 <5121F27F.9020102@pengutronix.de>
 <5122A383.7040804@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:20017 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933359Ab3BTIoE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Feb 2013 03:44:04 -0500
Content-Disposition: inline
In-Reply-To: <5122A383.7040804@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

On Mon, Feb 18, 2013 at 10:56:19PM +0100, Oliver Hartkopp wrote:
> 
> The code itself is working properly for a long time now. The only missing
> point is that i do not have a really good idea how to cope with the fact that
> up to 500 CAN frames can be pushed into the CAN netdev tx queue at a time.
> 
> The advisory to increase the tx_queue_len to 1000 is not a solution.
> 
> Maybe qdiscs is a solution or we need to be able to peek the tx queue state
> whether we can push the next CAN frame to the device, or if we need to wait.

the tx queue state thing seems very similar to what Felix asked for recently,
and I'm thinking such thing may improve any transport protocol also ...
> 
> Regards,
> Oliver
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
