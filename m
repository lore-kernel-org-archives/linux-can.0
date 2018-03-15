From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Thu, 15 Mar 2018 19:08:45 +0100
Message-ID: <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Fastabend <john.fastabend@gmail.com>, Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On 14.03.18 05:03, John Fastabend wrote:
> On 03/13/2018 11:35 AM, Dave Taht wrote:
>> On Tue, Mar 13, 2018 at 11:24 AM, Jakob Unterwurzacher
>> <jakob.unterwurzacher@theobroma-systems.com> wrote:
>>> During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on Linux
>>> v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of packets are
>>> delivered out-of-order.
>>>
> 
> Is the stress-testing tool available somewhere? What type of packets
> are being sent?


I have reproduced it using two USB network cards connected to each 
other. The test tool sends UDP packets containing a counter and listens 
on the other interface, it is available at
https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py

Here is what I get:

root@rk3399-q7:~# ./pfifo_stress.py
[...]
expected ctr 0xcdc, received 0xcdd
expected ctr 0xcde, received 0xcdc
expected ctr 0xcdd, received 0xcde
expected ctr 0xe3c, received 0xe3d
expected ctr 0xe3e, received 0xe3c
expected ctr 0xe3d, received 0xe3e
expected ctr 0x1097, received 0x1098
expected ctr 0x1099, received 0x1097
expected ctr 0x1098, received 0x1099
expected ctr 0x17c0, received 0x17c1
expected ctr 0x17c2, received 0x17c0
[...]

Best regards,
Jakob
