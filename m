From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] net: can: Increase tx queue length
Date: Fri, 15 Mar 2019 14:53:04 +0100
Message-ID: <f29c891a-2e21-3b9f-83d8-7abd48031011@hartkopp.net>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
 <87zhq43v4m.fsf@toke.dk> <87sgvvnwqf.fsf@taht.net>
 <9adf2fbb-7b0b-6821-98fb-2ddcdf5c0edd@hartkopp.net>
 <DM5PR02MB2187A422962182382358B916DC440@DM5PR02MB2187.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR02MB2187A422962182382358B916DC440@DM5PR02MB2187.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>, Dave Taht <dave@taht.net>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>, Andre Naujoks <nautsch2@gmail.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, Martin Jerabek <ma.jer@post.cz>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>
List-Id: linux-can.vger.kernel.org

Hi Kedar,

On 3/15/19 11:04 AM, Appana Durga Kedareswara Rao wrote:

>> Having about 10 elements in a CAN driver tx queue allows to work with
>> queueing disciplines
>> (http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf) and also to maintain a
>> nearly real-time behaviour with outgoing traffic.
>>
>> When the CAN interface is not able to cope with the (intened) outgoing traffic
>> load, the applications should get an instant feedback about it.
>>
>> There is a difference between running CAN applications in the real world and
>> doing performance tests, where it makes sense to increase the tx-queue-len to
>> e.g. 1000 and dump 1000 frames into the driver to check the hardware
>> performance.
> 
> Thanks, Oliver, Martin, Andre, Toke, Dave for your inputs...
> So to conclude this the default txqueuelen 10 is ideal for real-time CAN traffic,
> For Stress/Performance tests user manually need to increase the txqueuelen based on his requirements.
> 
> Please correct me if my understanding is wrong.

Yes, I would confirm that approach.

As Martin Jerabek pointed to a discussion with Michal Sojka here:

https://marc.info/?l=linux-can&m=155222580602047&w=2

You might also go for a more academic view based on the number of 
different CAN applications on the host.

@Martin: Would you like to propose a patch for can.txt (now can.rst)?

Regards,
Oliver
