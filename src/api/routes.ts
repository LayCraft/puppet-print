import { Request, Response, Express } from 'express';
import printPDF from './pdf';

export default function applyRoutes(app: Express) {

  /**
   * POST /pdf
   * PDF rendering.
   */
  app.post('/pdf', async function (req: Request, res: Response) {
    // set the filename if included in the request params
    const { filename = 'unnamed.pdf' } = req.query;
    // set the body request
    const html = req.body;
    // collect the buffer response
    const pdf = await printPDF(html);
    // set headers for response
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Length', pdf.length);
    // set the filename for the returned file
    res.setHeader('Content-Disposition', `inline;filename=${filename}`);
    // return the pdf
    res.send(pdf);
  });

  /**
   * GET /health
   * Server health check.
   */
  app.get('/health', async function (req: Request, res: Response) {
    res.send(`Puppet print lives! - ${new Date().toISOString()}`);
  });
}
