From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN device filterting
Date: Tue, 04 Sep 2012 15:40:51 +0200
Message-ID: <504604E3.1040305@hartkopp.net>
References: <1346765466.5440.3.camel@punsfloyd-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:13536 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab2IDNky (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 09:40:54 -0400
In-Reply-To: <1346765466.5440.3.camel@punsfloyd-desktop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: puneet.sharma@moschip.com
Cc: linux-can@vger.kernel.org

On 04.09.2012 15:31, Puneet Sharma wrote:

> I need some guidance on implementing the CAN filtering of identifier in
> the driver code of CAN for atmel AT91SAM9263 board. Please guide me how
> to proceed with it..


Hm - i wrote that some days ago:

The CAN netdev driver model is as easy and simple as ethernet devices.
To fulfill multi-user requirements the CAN driver disables any CAN controller
specific filters and mailboxes to enable all different users on the host to
filter their own requires messages, using the CAN filter infrastructure:

http://lxr.linux.no/#linux+v3.5.3/Documentation/networking/can.txt#L393

You can also check out the filter capabilities with the 'candump' tool, see
'candump -?'

Does this help?

Regards,
Oliver
