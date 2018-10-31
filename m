From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
Date: Wed, 31 Oct 2018 15:15:56 -0500
Message-ID: <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Wolfgang

Thanks for the review

On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> for the RFC, could you please just do the necessary changes to the
> existing code. We can discuss about better names, etc. later. For
> the review if the common code I quickly did:
> 
>   mv m_can.c m_can_platform.c
>   mv m_can_core.c m_can.c
> 
> The file names are similar to what we have for the C_CAN driver.
> 
>   s/classdev/priv/
>   variable name s/m_can_dev/priv/
> 
> Then your patch 1/3 looks as shown below. I'm going to comment on that
> one. The comments start with "***"....
> 

So you would like me to align the names with the c_can driver?

<snip>
> 
> *** I didn't review the rest of the patch for now.
> 

snipped the code to reply to the comment.

> Looking to the generic code, you didn't really change the way
> the driver is accessing the registers. Also the interrupt handling
> and rx polling is as it was before. Does that work properly using
> the SPI interface of the TCAN4x5x?

I don't want to change any of that yet.  Maybe my cover letter was not clear
or did not go through.

But the intention was just to break out the functionality to create a MCAN framework
that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
the registers in the device.

I don't want to do any functional changes at this time on the IP code itself until we have a framework.
There should be no regression in the io mapped code.

I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
For the original TCAN driver this was the way it was implemented.

> 
> I was also thinking about optimized read/write functions handling
> more than 4 bytes of data, e.g. for the CAN payload data. That
> would speed-up SPI transfers, I think. But that could also be
> introduced later-on.

That would be the plan.

> 
> Wolfgang.
> 
> 
> 
> 


-- 
------------------
Dan Murphy
