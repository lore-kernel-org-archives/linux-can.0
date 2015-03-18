From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] Join CAN filters with CAN_RAW_JOIN_FILTERS sockopt is ready
 for testing
Date: Wed, 18 Mar 2015 08:52:27 +0100
Message-ID: <55092EBB.5060603@hartkopp.net>
References: <550883AF.7080703@hartkopp.net> <550925B3.6010801@hartkopp.net> <95290d0cea49482e96eab6513a556c69@SGPMBX1011.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:28798 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbbCRHw3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Mar 2015 03:52:29 -0400
In-Reply-To: <95290d0cea49482e96eab6513a556c69@SGPMBX1011.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Pankaj

On 18.03.2015 08:48, Pankajkumar Misra (RBEI/EEA2) wrote:

> I have a question here.
>
> The filter used with candump are software filters or actual can device filter registers are updated ?
>

Yes. The CAN controllers are always operated without filters and all the 
filtering is done in the NET_RX softirq inside the Linux network layer.

See https://www.kernel.org/doc/Documentation/networking/can.txt Chapter 3.1

Regards,
Oliver
