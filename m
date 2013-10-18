From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Fri, 18 Oct 2013 12:55:29 +0200
Message-ID: <526113A1.8020403@kkmicro.cz>
References: <l3r0ki$hde$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.aquastore.cz ([37.157.193.242]:38830 "EHLO
	server.aquastore.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3JRLCq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Oct 2013 07:02:46 -0400
Received: from localhost (unknown [127.0.0.1])
	by server.aquastore.cz (Postfix) with ESMTP id A9D00ABC0D
	for <linux-can@vger.kernel.org>; Fri, 18 Oct 2013 10:55:32 +0000 (UTC)
Received: from server.aquastore.cz ([127.0.0.1])
	by localhost (server.aquastore.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHQiwybCw8wb for <linux-can@vger.kernel.org>;
	Fri, 18 Oct 2013 12:55:31 +0200 (CEST)
Received: from [127.0.0.1] (unknown [213.191.105.242])
	by server.aquastore.cz (Postfix) with ESMTPSA id 0C6E0ABBF7
	for <linux-can@vger.kernel.org>; Fri, 18 Oct 2013 12:55:31 +0200 (CEST)
In-Reply-To: <l3r0ki$hde$1@ger.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Dne 18.10.2013 11:56, Martin Kozusky napsal(a):
> Hello,
> is there any official way how to read timestamp from flexcans message
> buffer?
> I see there is a macro defined FLEXCAN_MB_CNT_TIMESTAMP in flexcan.c,
> but not used.
> I would modify function flecan_read_fifo like
>
> + u32 timestamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);

sorry, u32 should be just u16

> but what to do with timestamp variable next and how to read it in
> userspace? :) I could change structure can_frame and add  u32 timestamp
also u16, not u32

> into it, but it wouldn't be very nice hack I think.
>
> BTW: is timestamp read with SO_TIMESTAMP  actualy taken when CAN message
> arrives?
>
> Thanks,
> Martin
>

