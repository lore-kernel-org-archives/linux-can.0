From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: question about time stamp for writing can messages
Date: Wed, 17 Feb 2016 18:45:16 +0100
Message-ID: <56C4B1AC.5040400@hartkopp.net>
References: <56C4785C.1070900@dimter-weinig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:60198 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965220AbcBQRpV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Feb 2016 12:45:21 -0500
In-Reply-To: <56C4785C.1070900@dimter-weinig.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Fischer, Claudio" <Claudio.Fischer@weinig.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Claudio,

On 02/17/2016 02:40 PM, Fischer, Claudio wrote:

> I have a question about the time stamp for writing can messages:
> 
> I'm using the time stamp feature when reading can messages with 
> socketcan on linux.
> Is there a possibility to use the same clock reference / time stamp 
> feature for writing
> can messages?
> 
> I'm asking this, because I want to record all written and read can 
> messages in
> chronologic sequence without building my own timestamp for written messages.

When you run e.g. 'candump -ta <interface>' on a terminal you would see, that
even your sent CAN frames appear with a correct in-order timestamp.

When you send a CAN frame this CAN frame is 'echoed' back to the system to
allow all applications on your system (multi-user) to get the correct
representation of what happened on the wire.

The timestamp is usually set when the TX-ok interrupt occurred after the frame
has been successfully send on the CAN bus. Then the stamped frame is
'received' by the system again - so you already have a correct timestamp of
your outgoing CAN frames.

See http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L184

When you have a CAN driver that does not support the ECHO functionality (e.g.
slcan devices) the timestamp is generated on network layer as fallback - which
is not that precise and may be out of order then.

Usually you do not see the sent frame on your CAN_RAW socket, as it is
(historically) unusual to receive your own traffic.

If you want to receive the traffic on the same socket where it was sent you'll
have to set the CAN_RAW_RECV_OWN_MSGS socket option:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L537

Best regards,
Oliver
