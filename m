From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Tue, 3 Dec 2019 11:37:58 +0100
Message-ID: <82b02a62-51ff-4568-c33d-90223a2aed86@hartkopp.net>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
 <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
 <9e06266a-67f3-7352-7b87-2b9144c7c9a9@gmail.com>
 <3142c032-e46a-531c-d1b8-d532e5b403a6@hartkopp.net>
 <92c04159-b83a-3e33-91da-25a727a692d0@gmail.com>
 <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>
 <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f395f1e-b7d4-6254-2a0c-54029b4dc38f@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

No. I have analyzed several solutions which turn out to be either unsafe 
in processing or need some changes in af_packet :-(

I'm currently very busy @work but will come up with a discussion until 
end of this week.

There is no big pressure as the problem is more unpleasant than causing 
a real problem right now.

Best regards,
Oliver

On 03/12/2019 11.09, Marc Kleine-Budde wrote:
> On 11/20/19 9:10 PM, Oliver Hartkopp wrote:
> [...]
>> So the KMSAN detection was right at the end :-(
>>
>> I'll take a closer look to enable PF_PACKET to send CAN frames again
>> which will fix up the entire  problem.
> 
> I'm going to send a pull request today. Do you already have a fix for this?
> 
> regards,
> Marc
> 
