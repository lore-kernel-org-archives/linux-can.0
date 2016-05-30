From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Request for testing - Re: [PATCH v2 0/5] Add support for CAN FD to
 broadcast manager (CAN_BCM)
Date: Mon, 30 May 2016 20:43:13 +0200
Message-ID: <574C89C1.3030901@hartkopp.net>
References: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:54339 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161301AbcE3SnW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 May 2016 14:43:22 -0400
Received: from [192.168.1.200] (p3EE3FC46.dip0.t-ipconnect.de [62.227.252.70])
	by smtp.strato.de (RZmta 37.28 DYNA|AUTH)
	with ESMTPSA id D03af7s4UIhJ1ef
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Mon, 30 May 2016 20:43:19 +0200 (CEST)
In-Reply-To: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

this patch set enables CAN FD for the BCM.

I did some basic tests but I would appreciate if anyone could give it 
some additional testing.

At least it should not affect the original function with classic CAN 
frames as it aims to preserve the former binary interface ;-)

Feedback is welcome!

Best regards,
Oliver


On 05/30/2016 08:36 PM, Oliver Hartkopp wrote:
> This series adds the capability for the CAN broadcast manager to handle
> CAN FD frames analogue to the CAN frames. It allows sending as well as all
> known data filtering functions (including multiplex filtering).
>
> Changes in v2:
> Introduce a helper variable cfsiz to prevent multiple CFSIZ(op) operations
> in bcm_rx_handler() (patch 4/5).
>
> Oliver Hartkopp (5):
>    can: bcm: fix indention style
>    can: bcm: use CAN frame instead of can_frame in comments
>    can: bcm: unify bcm_msg_head handling and prepare function parameters
>    can: bcm: add support for CAN FD frames
>    can: bcm: add documentation for CAN FD support
>
>   Documentation/networking/can.txt |  22 +++
>   include/uapi/linux/can/bcm.h     |   1 +
>   net/can/bcm.c                    | 313 +++++++++++++++++++++++----------------
>   3 files changed, 206 insertions(+), 130 deletions(-)
>
