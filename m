From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] can-doc: Fixed a wrong filepath in can.txt
Date: Thu, 5 Feb 2015 10:00:53 -0500
Message-ID: <20150205100053.420e4941@lwn.net>
References: <1423146804-8530-1-git-send-email-stefan@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1423146804-8530-1-git-send-email-stefan@sevenbyte.org>
Sender: linux-doc-owner@vger.kernel.org
To: Stefan Tatschner <stefan@sevenbyte.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Thu,  5 Feb 2015 15:33:24 +0100
Stefan Tatschner <stefan@sevenbyte.org> wrote:

> -  described in the Linux header file "include/linux/can/error.h".
> +  described in the Linux header file "include/uapi/linux/can/error.h".

Looks good.  It needed a changelog, though, so I took the liberty of
adding one.

jon
