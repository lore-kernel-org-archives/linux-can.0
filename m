From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
Date: Mon, 20 Feb 2017 12:27:18 +0200
Message-ID: <6bc632d8-1654-6e95-08ce-76ac6754cb9d@bitwise.fi>
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
 <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 20.2.2017 11:42, Marc Kleine-Budde wrote:
> On 02/13/2017 04:39 PM, Anssi Hannula wrote:
>> The xilinx_can driver assumes that the TXOK interrupt only clears after
>> it has been acknowledged as many times as there have been successfully
>> sent frames.
>>
>> However, the documentation does not mention such behavior, instead
>> saying just that the interrupt is cleared when the clear bit is set.
>>
>> Similarly, testing seems to also suggest that it is immediately cleared
>> regardless of the amount of frames having been sent. Performing some
>> heavy TX load and then going back to idle has the tx_head drifting
>> further away from tx_tail over time, steadily reducing the amount of
>> frames the driver keeps in the TX FIFO (but not to zero, as the TXOK
>> interrupt always frees up space for 1 frame from the driver's
>> perspective, so frames continue to be sent) and delaying the local echo
>> frames.
>>
>> The TX FIFO tracking is also otherwise buggy as it does not account for
>> TX FIFO being cleared after software resets, causing
>>   BUG!, TX FIFO full when queue awake!
>> messages to be output.
>>
>> Since there does not seem to be any way to accurately track the state of
>> the TX FIFO, drop the code trying to do that and perform
>> netif_stop_queue() based on whether the HW reports the FIFO being full.
>> Driver-side local echo support is also removed as it is not possible to
>> do accurately (relying instead on the CAN core fallback support).
>>
>> Tested with the integrated CAN on Zynq-7000 SoC.
>>
>> v2: Add FIFO space check before TX queue wake with locking to
>> synchronize with queue stop. This avoids waking the queue when xmit()
>> had just filled it.
> Removing the echo on TX-complete should be avoided if possible. Is there
> a way to get a indication that an individual package has been send?

Looking at the reference manual [1, chapter 18 and appendix B.5] I can't
see any. The TX FIFO interrupts and status registers available are TXOK
(1 or more messages sent), FIFO empty, FIFO full, FIFO under watermark
(watermark not programmable while on-bus). There is no FIFO free space
counter that I can see.

One way would be to only put a single frame into the FIFO at a time, of
course, but at least to me that seems worse than losing echo-on-TX-complete.

[1]
https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf


-- 
Anssi Hannula / Bitwise Oy
+358503803997
