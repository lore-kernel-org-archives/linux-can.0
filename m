From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: RE: [PATCH] net: can: Increase tx queue length
Date: Sat, 09 Mar 2019 16:50:01 +0100
Message-ID: <87zhq43v4m.fsf@toke.dk>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com> <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com> <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>, Andre Naujoks <nautsch2@gmail.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Appana Durga Kedareswara Rao <appanad@xilinx.com> writes:

> Hi Andre,
>
> <Snip> 
>> 
>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>> > While stress testing the CAN interface on xilinx axi can in loopback
>> > mode getting message "write: no buffer space available"
>> > Increasing device tx queue length resolved the above mentioned issue.
>> 
>> No need to patch the kernel:
>> 
>> $ ip link set <dev-name> txqueuelen 500
>> 
>> does the same thing.
>
> Thanks for the review... 
> Agree but it is not an out of box solution right?? 
> Do you have any idea for socket can devices why the tx queue length is 10 whereas
> for other network devices (ex: ethernet) it is 1000 ??

Probably because you don't generally want a long queue adding latency on
a CAN interface? The default 1000 is already way too much even for an
Ethernet device in a lot of cases.

If you get "out of buffer" errors it means your application is sending
things faster than the receiver (or device) can handle them. If you
solve this by increasing the queue length you are just papering over the
underlying issue, and trading latency for fewer errors. This tradeoff
*may* be appropriate for your particular application, but I can imagine
it would not be appropriate as a default. Keeping the buffer size small
allows errors to propagate up to the application, which can then back
off, or do something smarter, as appropriate.

I don't know anything about the actual discussions going on when the
defaults were set, but I can imagine something along the lines of the
above was probably a part of it :)

-Toke
