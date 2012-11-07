From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] candump: Mark local CAN frames
Date: Wed, 7 Nov 2012 10:28:06 +0100
Message-ID: <20121107092806.GF416@vandijck-laurijssen.be>
References: <1352274831-20551-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:59012 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380Ab2KGJ2K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 04:28:10 -0500
Content-Disposition: inline
In-Reply-To: <1352274831-20551-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On Wed, Nov 07, 2012 at 08:53:51AM +0100, Alexander Stein wrote:
> Mark CAN frames with an * after the CAN interface to indicate it
> originates from the same host.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

I already felt the need for such thing since Oliver & I added the kernel
code for this.
Thanks,

Acked-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
