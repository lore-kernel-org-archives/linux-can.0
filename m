From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
Date: Mon, 04 Mar 2019 18:48:58 -0800
Message-ID: <fafe78cbb34dc8acd31f873bcd55af879311d839.camel@perches.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
         <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
         <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
         <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
         <cc3d0c0c-f56f-0bb5-e90b-a09cdf761f3c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cc3d0c0c-f56f-0bb5-e90b-a09cdf761f3c@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Mon, 2019-03-04 at 13:12 -0600, Dan Murphy wrote:
> On 3/4/19 12:13 PM, Wolfgang Grandegger wrote:
> > Am 04.03.19 um 18:22 schrieb Dan Murphy:
> > > > > +	int pm_clock_support;
> > > > 
> > > > A "bool" would be more appropriate, I think.
> > > 
> > > I was abiding by this checkpatch warning I got on the is_peripherial.
> > > 
> > > CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
> > > #94: FILE: drivers/net/can/m_can/m_can.h:94:
> > > +	bool is_peripherial;
> > > 
> > 
> > Ah, right! I was also surprised to get that warning. The kernel is full
> > of bool's, but well, we should make "checkpatch" happy (and Linus).

That check has been removed from checkpatch by

commit 7967656ffbfa493f5546c0f18bf8a28f702c4baa
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri Jan 18 15:50:47 2019 -0700

    coding-style: Clarify the expectations around bool
    
    There has been some confusion since checkpatch started warning about bool
    use in structures, and people have been avoiding using it.
    
    Many people feel there is still a legitimate place for bool in structures,
    so provide some guidance on bool usage derived from the entire thread that
    spawned the checkpatch warning.
    
    Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com
