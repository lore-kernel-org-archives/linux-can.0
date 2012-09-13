From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/2] mfd/janz-cmodio: fix MODULBus number sysfs entry
Date: Thu, 13 Sep 2012 14:52:01 +0200
Message-ID: <20120913125201.GB3647@sortiz-mobl>
References: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
 <1347404295-7985-2-git-send-email-iws@ovro.caltech.edu>
 <5051C9F0.3050600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5051C9F0.3050600@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Thu, Sep 13, 2012 at 01:56:32PM +0200, Marc Kleine-Budde wrote:
> On 09/12/2012 12:58 AM, Ira W. Snyder wrote:
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > Revision 1.0 of the Janz CMOD-IO Carrier Board does not contain zeroes
> > in the top 4 bits of the modulbus_num (int_enable) register. Mask off
> > the unused bits so that the correct value is displayed in sysfs.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> 
> Who will take care of this patch?
I will.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
