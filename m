From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [RFC] input: cap11xx: plasma globe proof
Date: Thu, 9 Jan 2020 21:03:34 +0100
Message-ID: <20200109200334.GA19438@x1.vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Ping?

On zo, 29 dec 2019 20:21:11 +0100, Kurt Van Dijck wrote:
> Hey,
> 
> I built a raspberry-pi wakeup for my kids. Recently, one of them bought
> a plasma globe. That globe leaves an electrostatic field that disturbes
> the cap11xx when it operates with default settings.
> So I grabbed the datasheet and started modifying the configuration.
> This is the result that should apply to other scenarios as well.
> 
> The patch series improves the cap11xx in 2 ways.
> It adds support for a cap1208 as on the explorer hat of Pimoroni,
> and allows to run in polling mode (the explorer hat omitted the irq,
> or I didn't find it).
> It then exposes the major configuration parts of the chip so one can
> tune it to her/his needs.
> 
> Please feel free to comment
> 
> Kind regards,
> Kurt
> 
