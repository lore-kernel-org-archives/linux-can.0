From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN message timestamping
Date: Wed, 23 Mar 2016 08:00:47 +0100
Message-ID: <56F23F1F.6040101@hartkopp.net>
References: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:46420 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbcCWHA6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2016 03:00:58 -0400
In-Reply-To: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

Hi Austin,

On 23.03.2016 06:12, Austin Schuh wrote:
> We recently tried doing CAN timestamping with the ioctl(s, SIOCGSTAMP,
> &tv) call.

Did you ever try to use the recvmsg() call with enabled SO_TIMESTAMPING socket 
option?

See:

https://www.kernel.org/doc/Documentation/networking/timestamping.txt
https://www.kernel.org/doc/Documentation/networking/timestamping/

The candump tool also uses recvmsg() - but only with SO_TIMESTAMP so far which 
does not provide the other RX timestamps (link HW TS).

Regards,
Oliver

