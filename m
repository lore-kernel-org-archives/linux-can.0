From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 03 Apr 2014 16:55:56 +0200
Message-ID: <17044566.IbTu3WUyuf@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50748 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265AbaDCO5L (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 10:57:11 -0400
In-Reply-To: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Just for the records in this thread:

based on tag 'linux-can-fixes-for-3.15-20140401' on repository git://gitorious.org/linux-can/linux-can I have noticed message losts(only one message each time). Interestingly 'candump any,0~0,#FFFFFFFF' didn't show yn error frames.
From 500000 CAN frames I lost 72 frames.

On Thursday 03 April 2014 16:14:11, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/net/can/c_can/c_can_pci.c | 50 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

