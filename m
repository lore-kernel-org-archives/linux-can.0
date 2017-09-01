From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 19/25] can/bcm: Replace hrtimer_tasklet with softirq based
 hrtimer
Date: Fri, 1 Sep 2017 19:02:05 +0200
Message-ID: <d9bd59f5-9478-5df1-b83a-40a22ebad673@hartkopp.net>
References: <20170831105725.809317030@linutronix.de>
 <20170831105827.099510718@linutronix.de>
 <bd72d6f1-ee96-821c-fbf3-766354728a40@hartkopp.net>
 <alpine.DEB.2.20.1709011755170.1857@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1709011755170.1857@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 09/01/2017 05:56 PM, Thomas Gleixner wrote:
> On Fri, 1 Sep 2017, Oliver Hartkopp wrote:

>>
>> On 08/31/2017 02:23 PM, Anna-Maria Gleixner wrote:
>>
>> (nothing here!)
>>
>> Please send patches inline and not as attachments. Tnx!
> 
> PS:
> 
> Content-Type: text/plain; charset=UTF-8
> Content-Disposition: inline;
>   filename=canbcm_Replace_hrtimer_tasklet_with_softirq_based_hrtimer.patch
> 
> Please get a proper mail client, which actually parses the
> Content-Disposition tag correcly
> 

Aah!

Setting

	mail.reply_quote_inline = true

in the config editor fixes that issue when replying a quilt post with 
Thunderbird.

Tnx!

Best,
Oliver
