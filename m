From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 24 Jul 2019 08:47:54 +0200
Message-ID: <20190724064754.GC22447@kroah.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
 <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
 <6fa79302-ad32-7f43-f9d5-af70aa789284@ti.com>
 <f236a88a-485c-9002-1e4a-9a5ad0e1c81f@ti.com>
 <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Tue, Jul 23, 2019 at 10:14:14AM -0500, Dan Murphy wrote:
> Hello
> 
> On 7/10/19 7:08 AM, Dan Murphy wrote:
> > Hello
> > 
> > On 6/17/19 10:09 AM, Dan Murphy wrote:
> > > Marc
> > > 
> > > On 6/10/19 11:35 AM, Dan Murphy wrote:
> > > > Bump
> > > > 
> > > > On 6/6/19 8:16 AM, Dan Murphy wrote:
> > > > > Marc
> > > > > 
> > > > > Bump
> > > > > 
> > > > > On 5/31/19 6:51 AM, Dan Murphy wrote:
> > > > > > Marc
> > > > > > 
> > > > > > On 5/15/19 3:54 PM, Dan Murphy wrote:
> > > > > > > Marc
> > > > > > > 
> > > > > > > On 5/9/19 11:11 AM, Dan Murphy wrote:
> > > > > > > > Create a m_can platform framework that peripheral
> > > > > > > > devices can register to and use common code and register sets.
> > > > > > > > The peripheral devices may provide read/write and configuration
> > > > > > > > support of the IP.
> > > > > > > > 
> > > > > > > > Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> > > > > > > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > v12 - Update the m_can_read/write functions to
> > > > > > > > create a backtrace if the callback
> > > > > > > > pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
> > > > > > > > 
> > > > > > > Is this able to be merged now?
> > > > > > 
> > > > > > ping
> > > 
> > > Wondering if there is anything else we need to do?
> > > 
> > > The part has officially shipped and we had hoped to have driver
> > > support in Linux as part of the announcement.
> > > 
> > Is this being sent in a PR for 5.3?
> > 
> > Dan
> > 
> Adding Greg to this thread as I have no idea what is going on with this. 

Why me?  What am I supposed to do here?  I see no patches at all to do
anything with :(

thanks,

greg "not a miracle worker" k-h
