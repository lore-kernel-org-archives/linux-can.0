From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 19/25] can/bcm: Replace hrtimer_tasklet with softirq based
 hrtimer
Date: Fri, 1 Sep 2017 17:49:38 +0200
Message-ID: <bd72d6f1-ee96-821c-fbf3-766354728a40@hartkopp.net>
References: <20170831105725.809317030@linutronix.de>
 <20170831105827.099510718@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831105827.099510718@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anna-Maria Gleixner <anna-maria@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.org>, keescook@chromium.org, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Anna-Maria & Thomas,

thanks for the effort!

I'm really happy that the hrtimer becomes softirq capable as it 
basically reverts this ugly commit from January 2009:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6e5c172cf7ca1ab878cc6a6a4c1d52fef60f3ee0

 From the first look the changes seem to be correct.

I'll pick the entire patchset for a test and give a Acked|Tested-by then.

Best regards,
Oliver

ps.

On 08/31/2017 02:23 PM, Anna-Maria Gleixner wrote:

(nothing here!)

Please send patches inline and not as attachments. Tnx!
