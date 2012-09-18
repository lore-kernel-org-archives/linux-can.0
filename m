From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:46:50 +0200
Message-ID: <50587B4A.6080806@grandegger.com>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <CACJ51z1g+A2Hy5SXU=1AmwyDYRuxv=MzsyVjAwiRWaOSRn+h7A@mail.gmail.com> <50577B03.60105@hartkopp.net> <CACJ51z2=T1M065ubm6sLt=utWo3ndZAL9YJNdeGQuS=2uR8EZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54143 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2IRNqz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:46:55 -0400
In-Reply-To: <CACJ51z2=T1M065ubm6sLt=utWo3ndZAL9YJNdeGQuS=2uR8EZA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/18/2012 03:36 PM, Andrew Bell wrote:
> On Mon, Sep 17, 2012 at 2:33 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 17.09.2012 21:26, Andrew Bell wrote:
>>
>> The TX timeout functionality has been removed a long time ago. There was a
>> discussion about that topic that days.
>>
>> So what kind of driver do you have there? A PEAK PCAN driver?
> 
> We're using an old mscan driver.
> 
> So, what's supposed to happen?  Does the hardware just attempt to send
> once and then drop the packet if no acknowledgement is received?  Is
> an error frame generated?  Is the issue being discussed just one where
> the application writes faster than the frames can be put onto the bus,
> rather than the condition of the bus being bad?

The CAN hardware usually *retries* to send to message until you abort it
or stop the device (going bus-off). If the message does not go out,
first the hardware and then the software queues will fill up and finally
the send() fails with errno=ENOBUFS. The send can also end up returning
ENOBUFS if the CPU is sending faster than the packets go out. Hope this
answers your question.

Wolfgang.
