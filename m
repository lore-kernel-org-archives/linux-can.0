From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BUG/Q] can_pernet_exit() leaves devices on dead net
Date: Mon, 2 Apr 2018 17:28:15 +0200
Message-ID: <377fbd8a-cd7e-2650-8efd-907cea0a0aee@hartkopp.net>
References: <8c941b2d-0c90-ba6c-6020-23530b146fd9@virtuozzo.com>
 <38145688-1c15-3df4-c127-591959a759ff@hartkopp.net>
 <21bafe4a-984f-2897-b092-270ccda136f0@virtuozzo.com>
 <9f3585bb-4cf9-b0e1-3069-37fbae2ce54b@hartkopp.net>
 <d97f5629-6de5-0d24-8a48-01a612a39bc9@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d97f5629-6de5-0d24-8a48-01a612a39bc9@virtuozzo.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Kirill Tkhai <ktkhai@virtuozzo.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, dev@kicherer.org
List-Id: linux-can.vger.kernel.org

Hi Kirill, Marc,

I checked the code once more and added some debug output to the other 
parts in CAN notifier code.

In fact the code pointed to by both of you seems to be obsolete as I 
only wanted to be 'really sure' that no leftovers of the CAN filters at 
module unloading.


> Yes, this one looks good:
> https://marc.info/?l=linux-can&m=150169589119335&w=2
> 
> Regards,
> Kirill
> 

I was obviously too cautious ;-)

All tests I made resulted in the function iterating through all the CAN 
netdevices doing exactly nothing.

I'm fine with removing that stuff - but I'm not sure whether it's worth 
to push that patch to stable 4.12+ or even before 4.12 (without 
namespace support - and removing rcu_barrier() too).

Any opinions?

Best regards,
Oliver
